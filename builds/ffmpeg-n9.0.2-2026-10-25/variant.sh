#!/bin/bash
# A reduced LGPL variant of BtbN/FFmpeg-Builds (MIT, Copyright 2020-2021 BtbN): copied from its
# variants/linux64-lgpl.sh at autobuild-2026-09-30-13-08 (commit 6c9aec5fc9a72ec3abedd1fa84db141fa18cf52b), then
# adapted. build-ffmpeg.sh installs it as variants/<target>-lgpl.sh of a BtbN checkout, in place of BtbN's own, so
# BtbN's build.sh sources it after util/vars.sh and before its `docker run`.
#
# What it adds to `lgpl`:
#   - FF_CONFIGURE ends with the reduced flags below. BtbN's build.sh reads FF_CONFIGURE from the build image's
#     environment, so build-ffmpeg.sh derives that image with this list appended to the image's own; FFmpeg's
#     configure keeps the last of two contradicting flags, so these win over the image's `--enable-libzvbi`.
#   - IMAGE names that derived image, which build-ffmpeg.sh exports as FFMPEG_DERIVED_IMAGE before calling build.sh.
# Everything else of `lgpl` stays: zscale, tonemap, bwdif, libopenh264, libplacebo and the VAAPI, QSV, NVENC and
# AMF encoders the image carries. No --enable-gpl, no --enable-nonfree.
# shellcheck disable=SC2034 # BtbN's build.sh reads every variable set here
# shellcheck source=/dev/null # the two files sit beside this one inside the BtbN checkout
source "$(dirname "${BASH_SOURCE[0]}")"/linux-install-static.sh
# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")"/defaults-lgpl.sh

# libzvbi compiles two GPL-2-only files into the library BtbN links statically. No network protocol, no playlist or
# concat demuxer, no device: a hostile stream reaches FFmpeg only through pipe:0 and cannot make it open a file, a URL
# or a device. rawvideo stays as the input of a one-frame hardware encoder self-test. liboapv, the APV encoder, is left
# out: the build image carries a newer liboapv than n9.0.2's wrapper calls (`oapvm_create` takes two arguments there,
# one in libavcodec/liboapvenc.c), so the tag does not compile against it.
FF_CONFIGURE="$FF_CONFIGURE --disable-libzvbi --disable-liboapv --disable-network --disable-protocols --enable-protocol=pipe,file \
--disable-demuxers --enable-demuxer=mpegts,mov,matroska,aac,mp3,ac3,eac3,rawvideo \
--disable-muxers --enable-muxer=hls,mp4,mpegts,webvtt,null \
--disable-devices --disable-indevs --disable-outdevs"

IMAGE="${FFMPEG_DERIVED_IMAGE:?build-ffmpeg.sh exports FFMPEG_DERIVED_IMAGE, the derived build image}"
