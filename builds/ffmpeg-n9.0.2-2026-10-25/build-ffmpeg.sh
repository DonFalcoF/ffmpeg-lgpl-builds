#!/usr/bin/env bash
# Builds a reduced LGPL FFmpeg for one target with BtbN/FFmpeg-Builds' own build.sh (MIT), the way its README
# documents ("./build.sh target variant"), from a BtbN checkout the caller made at the pinned tag:
#   1. installs variant.sh as variants/<target>-lgpl.sh of that checkout, in place of BtbN's own;
#   2. pulls BtbN's prebuilt lgpl 9.0 build image of <target> by the digest of the pin (every dependency already
#      compiled into it) and derives it with the variant's FF_CONFIGURE appended to the image's own, since build.sh
#      runs configure with the image's FF_CONFIGURE, never the variant's;
#   3. runs build.sh on FFmpeg's tag `version` of the pin (GIT_BRANCH_OVERRIDE, which build.sh documents), then
#      moves the archive into <out-dir> with its `.sha256` beside it.
# The build images are amd64 only: on an arm64 machine Docker runs them through Rosetta, and the linuxarm64 image
# cross-compiles.
# Usage: build-ffmpeg.sh <linux64|linuxarm64> <btbn-checkout> <out-dir>
# Exit: 0 built, 1 a step failed, 2 usage.
set -euo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck source=scripts/lib/ffmpeg-pin.sh
source "$repository_root/scripts/lib/ffmpeg-pin.sh"

PIN_FILE="$repository_root/infra/ffmpeg/ffmpeg.pin"
VARIANT_FILE="$repository_root/infra/ffmpeg/variant.sh"
BUILD_IMAGE_PLATFORM='linux/amd64'
DERIVED_IMAGE_REPOSITORY='ffmpeg-lgpl-build'
# ghcr.io drops a layer request now and then ("net/http: timeout awaiting response headers"); a second pull succeeds.
PULL_ATTEMPTS=5
PULL_RETRY_DELAY_SECONDS=10

if [[ $# -ne 3 ]] || ! ffmpeg_is_target "$1"; then
    echo "usage: build-ffmpeg.sh <$(IFS='|'; echo "${FFMPEG_TARGETS[*]}")> <btbn-checkout> <out-dir>" >&2
    exit 2
fi
target="$1"
btbn_checkout="$(cd "$2" && pwd)"
out_dir="$3"

version="$(ffmpeg_pin_value "$PIN_FILE" version)"
build_image="$(ffmpeg_pin_value "$PIN_FILE" "$target.image")"
if [[ -z "$version" || -z "$build_image" ]]; then
    echo "build-ffmpeg: $PIN_FILE names no version or no $target.image" >&2
    exit 1
fi
if [[ ! -x "$btbn_checkout/build.sh" || ! -f "$btbn_checkout/variants/linux-install-static.sh" ]]; then
    echo "build-ffmpeg: $btbn_checkout is not a BtbN/FFmpeg-Builds checkout" >&2
    exit 1
fi

variant_name="$target-$FFMPEG_VARIANT"
cp "$VARIANT_FILE" "$btbn_checkout/variants/$variant_name.sh"
# The variant's FF_CONFIGURE, read the way build.sh reads it: sourced from inside the checkout.
extra_configure="$(cd "$btbn_checkout" && FFMPEG_DERIVED_IMAGE=unused bash -c \
    'source "variants/$1.sh" && printf "%s" "$FF_CONFIGURE"' _ "$variant_name")"
echo "build-ffmpeg: appending to the image's FF_CONFIGURE: $extra_configure"

attempt=1
until docker pull --platform "$BUILD_IMAGE_PLATFORM" "$build_image"; do
    echo "build-ffmpeg: pull attempt $attempt of $PULL_ATTEMPTS failed for $build_image" >&2
    if [[ "$attempt" -ge "$PULL_ATTEMPTS" ]]; then
        echo "build-ffmpeg: could not pull the build image $build_image in $PULL_ATTEMPTS attempts" >&2
        exit 1
    fi
    attempt=$((attempt + 1))
    sleep "$PULL_RETRY_DELAY_SECONDS"
done
derived_image="$DERIVED_IMAGE_REPOSITORY:$target"
# ENV substitution reads the base image's own FF_CONFIGURE (docs.docker.com, Dockerfile reference, "Environment
# replacement"); nothing runs in this build, so it needs no emulation.
# shellcheck disable=SC2016 # ${FF_CONFIGURE} is Dockerfile syntax, expanded by docker build, not by this shell
printf 'FROM %s\nARG EXTRA_CONFIGURE\nENV FF_CONFIGURE="${FF_CONFIGURE} ${EXTRA_CONFIGURE}"\n' "$build_image" |
    docker build --platform "$BUILD_IMAGE_PLATFORM" --build-arg EXTRA_CONFIGURE="$extra_configure" \
        --tag "$derived_image" -

# BtbN's scripts need bash 4 or later (`shopt -s globstar`, `${REPO,,}`), so they run under the `bash` of PATH rather
# than their `#!/bin/bash`, which is bash 3.2 on macOS.
(cd "$btbn_checkout" && FFMPEG_DERIVED_IMAGE="$derived_image" GIT_BRANCH_OVERRIDE="$version" bash ./build.sh "$target" "$FFMPEG_VARIANT")

archive="$(ffmpeg_archive_name "$version" "$target")"
if [[ ! -f "$btbn_checkout/artifacts/$archive" ]]; then
    echo "build-ffmpeg: build.sh produced no $archive (FFmpeg's tag is not $version?); artifacts holds:" >&2
    ls -1 "$btbn_checkout/artifacts" >&2 || true
    exit 1
fi
mkdir -p "$out_dir"
mv "$btbn_checkout/artifacts/$archive" "$out_dir/$archive"
(cd "$out_dir" && sha256sum "$archive" > "$archive.sha256" && cat "$archive.sha256")
