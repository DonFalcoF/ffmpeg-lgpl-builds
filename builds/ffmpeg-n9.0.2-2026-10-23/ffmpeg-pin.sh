#!/usr/bin/env bash
# Sourced, never run: the one reader of the FFmpeg pin file (ffmpeg.pin), shared by every script that builds, fetches,
# packs or watches the build, so none parses it another way.
# The file is `key=value` lines and `#` comments; a key is matched whole, dots included (`linux64.sha256`).

# The two targets built, in BtbN's names: x86_64 and aarch64 Linux.
FFMPEG_TARGETS=(linux64 linuxarm64)

# The BtbN variant name build-ffmpeg.sh installs variant.sh under, which also names the archives.
FFMPEG_VARIANT='lgpl'

# What every reader prints while the pin names no release.
# shellcheck disable=SC2034 # read by the scripts that source this file
FFMPEG_PIN_EMPTY_MESSAGE='The FFmpeg pin has no release yet: run the ffmpeg-build workflow'

# Prints the value of <key> in <pin-file>, or nothing when the key is absent or empty; fails when the file is
# unreadable, so a missing pin is never read as an empty one.
ffmpeg_pin_value() { # <pin-file> <key>
    local pin_file="$1" key="$2"
    if [[ ! -r "$pin_file" ]]; then
        echo "ffmpeg-pin: cannot read $pin_file" >&2
        return 1
    fi
    awk -v key="$key" 'index($0, key "=") == 1 { print substr($0, length(key) + 2); exit }' "$pin_file"
}

# Prints the archive name of <target> for <version>, as BtbN's build.sh names it: ffmpeg-<version>-<target>-<variant>.
ffmpeg_archive_name() { # <version> <target>
    printf 'ffmpeg-%s-%s-%s.tar.xz\n' "$1" "$2" "$FFMPEG_VARIANT"
}

# Succeeds when <target> is one of FFMPEG_TARGETS.
ffmpeg_is_target() { # <target>
    local candidate
    for candidate in "${FFMPEG_TARGETS[@]}"; do
        [[ "$candidate" == "$1" ]] && return 0
    done
    return 1
}
