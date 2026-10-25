#!/usr/bin/env bash
# Checks a built FFmpeg against its reduced LGPL configuration before it is uploaded: the licence
# FFmpeg reports is the LGPL and names no nonfree part, `-buildconf` holds no --enable-gpl or --enable-nonfree, the only
# input protocols of ffmpeg and of ffprobe are `file` and `pipe`, the demuxers of both are exactly the reduced list
# (rawvideo included for a one-frame hardware encoder self-test; no hls, concat, image2, sami, srt or webvtt), the
# muxers it must write are present, libzvbi is absent, and what transcoding uses stayed (libopenh264, zscale, tonemap,
# bwdif, libplacebo). Every finding is named.
#
# Fails closed: every listing is captured whole before it is read, so a binary that crashes, cannot run or prints
# nothing stops the script naming its command, and no `grep -q` reads a pipe whose writer it could cut short (under
# pipefail the writer's SIGPIPE would read as "not found").
# Usage: check-ffmpeg-build.sh <ffmpeg> <ffprobe>
# Exit: 0 every check passed, 1 a check failed or a command failed (each one printed), 2 usage.
set -euo pipefail

LICENCE_NAME='GNU Lesser General Public License'
# What FFmpeg's -L adds when CONFIG_NONFREE is set ("This version of ffmpeg has nonfree parts compiled in.").
NONFREE_MARKER='nonfree'
FORBIDDEN_CONFIGURE_FLAGS=(--enable-gpl --enable-nonfree)
ALLOWED_INPUT_PROTOCOLS='file pipe'
# The names `-demuxers` prints: a demuxer with aliases prints them comma-joined.
EXPECTED_DEMUXERS='aac ac3 eac3 matroska,webm mov,mp4,m4a,3gp,3g2,mj2 mp3 mpegts rawvideo'
FORBIDDEN_DEMUXERS=(hls concat image2 sami srt webvtt)
REQUIRED_MUXERS=(hls mp4 mpegts webvtt null)
REQUIRED_ENCODERS=(libopenh264)
REQUIRED_FILTERS=(zscale tonemap bwdif libplacebo)
ZVBI_MARKER='zvbi'

if [[ $# -ne 2 ]]; then
    echo "usage: check-ffmpeg-build.sh <ffmpeg> <ffprobe>" >&2
    exit 2
fi
ffmpeg="$1"
ffprobe="$2"
failures=0

fail() {
    echo "FAIL: $*"
    failures=$((failures + 1))
}

pass() {
    echo "ok: $*"
}

# Prints the whole output of `<binary> -hide_banner <flag>`; returns 1, naming the command, when it fails, cannot run
# or prints nothing. Every caller assigns it at the top level, where `set -e` stops the script on that status.
capture() { # <binary> <flag>
    local output status=0
    output="$("$1" -hide_banner "$2")" || status=$?
    if [[ "$status" -ne 0 || -z "$output" ]]; then
        echo "FAIL: '$1 -hide_banner $2' exited $status with ${#output} bytes of output" >&2
        return 1
    fi
    printf '%s\n' "$output"
}

# Passes when <name> is a whole line of <listing>, fails naming it otherwise.
require_listed() { # <kind> <name> <listing>
    if grep -qx -- "$2" <<<"$3"; then
        pass "$1: $2"
    else
        fail "$1: $2 is missing"
    fi
}

# The name on each line after the ` ---` separator of `-encoders`, `-decoders` and `-filters`: the second column.
listed_names() { # <listing>
    awk 'listing { print $2 } /^ *-+$/ { listing = 1 }' <<<"$1"
}

# The name on each line after the separator of `-demuxers` and `-muxers`, which start with a fixed three-character
# flag column (` D d avfoundation` for a device), so the name is the first word from the sixth character.
format_names() { # <listing>
    awk 'listing { split(substr($0, 6), words, " "); print words[1] } /^ *-+$/ { listing = 1 }' <<<"$1"
}

# The input protocols and the demuxers of <binary> (ffmpeg and ffprobe both read hostile input): exact lists.
check_inputs() { # <name> <protocols listing> <demuxers listing>
    local protocols demuxers demuxer_lines demuxer
    protocols="$(awk '/^Output:/ { exit } listing { print $1 } /^Input:/ { listing = 1 }' <<<"$2" | sort | xargs)"
    if [[ "$protocols" == "$ALLOWED_INPUT_PROTOCOLS" ]]; then
        pass "$1 input protocols: $protocols"
    else
        fail "$1 input protocols: expected '$ALLOWED_INPUT_PROTOCOLS', listed '$protocols'"
    fi
    demuxers="$(format_names "$3" | sort | xargs)"
    if [[ "$demuxers" == "$EXPECTED_DEMUXERS" ]]; then
        pass "$1 demuxers: $demuxers"
    else
        fail "$1 demuxers: expected '$EXPECTED_DEMUXERS', listed '$demuxers'"
    fi
    demuxer_lines="$(tr ' ,' '\n' <<<"$demuxers")"
    for demuxer in "${FORBIDDEN_DEMUXERS[@]}"; do
        if grep -qx -- "$demuxer" <<<"$demuxer_lines"; then
            fail "$1 demuxers: $demuxer is listed"
        fi
    done
}

ffprobe_version="$(capture "$ffprobe" -version)"
head -n 1 <<<"$ffprobe_version"

licence="$(capture "$ffmpeg" -L)"
if grep -q "$LICENCE_NAME" <<<"$licence"; then
    pass "licence: $(grep -m 1 "$LICENCE_NAME" <<<"$licence" | sed 's/^ *//')"
else
    fail "licence: -L does not name the $LICENCE_NAME: $(head -n 2 <<<"$licence" | tr '\n' ' ')"
fi
if grep -qi "$NONFREE_MARKER" <<<"$licence"; then
    fail "licence: -L names nonfree parts: $(grep -i -m 1 "$NONFREE_MARKER" <<<"$licence")"
else
    pass "licence: -L names no nonfree part"
fi

buildconf="$(capture "$ffmpeg" -buildconf)"
for flag in "${FORBIDDEN_CONFIGURE_FLAGS[@]}"; do
    if grep -q -- "$flag\$" <<<"$buildconf"; then
        fail "buildconf: $flag is configured"
    else
        pass "buildconf: no $flag"
    fi
done

ffmpeg_protocols="$(capture "$ffmpeg" -protocols)"
ffmpeg_demuxers="$(capture "$ffmpeg" -demuxers)"
check_inputs ffmpeg "$ffmpeg_protocols" "$ffmpeg_demuxers"
ffprobe_protocols="$(capture "$ffprobe" -protocols)"
ffprobe_demuxers="$(capture "$ffprobe" -demuxers)"
check_inputs ffprobe "$ffprobe_protocols" "$ffprobe_demuxers"

muxers_listing="$(capture "$ffmpeg" -muxers)"
muxers="$(format_names "$muxers_listing" | tr ',' '\n')"
for muxer in "${REQUIRED_MUXERS[@]}"; do
    require_listed muxer "$muxer" "$muxers"
done

encoders_listing="$(capture "$ffmpeg" -encoders)"
encoders="$(listed_names "$encoders_listing")"
for encoder in "${REQUIRED_ENCODERS[@]}"; do
    require_listed encoder "$encoder" "$encoders"
done
echo "hardware encoders: $(grep -E '_(vaapi|qsv|nvenc|amf)$' <<<"$encoders" | xargs || true)"

filters_listing="$(capture "$ffmpeg" -filters)"
filters="$(listed_names "$filters_listing")"
for filter in "${REQUIRED_FILTERS[@]}"; do
    require_listed filter "$filter" "$filters"
done

decoders_listing="$(capture "$ffmpeg" -decoders)"
decoders="$(listed_names "$decoders_listing")"
if grep -q -- "$ZVBI_MARKER" <<<"$decoders"; then
    fail "decoders: a libzvbi decoder is listed: $(grep -m 1 -- "$ZVBI_MARKER" <<<"$decoders")"
else
    pass "decoders: no libzvbi"
fi

if [[ "$failures" -gt 0 ]]; then
    echo "check-ffmpeg-build: $failures check(s) failed" >&2
    exit 1
fi
echo "check-ffmpeg-build: every check passed"
