# ffmpeg-lgpl-builds

A reduced LGPL build of FFmpeg from BtbN's scripts (BtbN/FFmpeg-Builds, MIT): the binaries and their whole
corresponding source. This repository holds nothing else: no workflow runs here, and each build is published as an
immutable release.

## What a release holds

Each release, tagged `ffmpeg-<version>-<date>`, holds:

| Asset | What it is |
| --- | --- |
| `ffmpeg-<version>-linux64-lgpl.tar.xz` | `ffmpeg` and `ffprobe` for x86_64 Linux (glibc), with FFmpeg's `LICENSE.txt` |
| `ffmpeg-<version>-linuxarm64-lgpl.tar.xz` | the same for aarch64 Linux |
| `ffmpeg-<version>-lgpl-source.tar.xz` | FFmpeg's tree at `<version>`, BtbN's scripts at the ref built with, and the build inputs (`build-inputs/`: the variant holding the configure line, the build script, the pin) |
| `ffmpeg-<version>-lgpl-libraries-source.tar.xz` | the source of every library the build links or is built against, at the commits the build images compiled, downloaded by BtbN's own `download.sh` stage scripts, with BtbN's tree at that commit and `STAGES.tsv` (each library's repository and commit) |
| `*.sha256`, `SHA256SUMS` | the SHA-256 of each archive |

`builds/<tag>/` holds the build inputs of that release (`variant.sh`, `build-ffmpeg.sh`, `ffmpeg-pin.sh`,
`check-ffmpeg-build.sh`, `ffmpeg.pin` as built), so each release's tag names a commit holding what drove it.

## The build

FFmpeg built with BtbN's `lgpl` dependencies and BtbN's prebuilt `lgpl` 9.0 build images, reduced to reading and
writing a few container formats: `--disable-network --disable-protocols --enable-protocol=pipe,file`, the demuxers
`mpegts`, `mov`, `matroska`, `aac`, `mp3`, `ac3`, `eac3` and `rawvideo` only, the muxers `hls`, `mp4`, `mpegts`,
`webvtt` and `null`, no device, no libzvbi, no liboapv. No `--enable-gpl`, no `--enable-nonfree`; BtbN configures
every variant with `--enable-version3`.

## Licence

The binaries are licensed under the GNU Lesser General Public License, version 3 or later (`COPYING.LGPLv3`, a set of
additional permissions on `COPYING.GPLv3`). This software uses code of FFmpeg licensed under the LGPLv3; its source
is the `-source` archive of each release. Each library linked into the binaries keeps its own licence: `NOTICE.md`
names them, `LICENSES/` holds each one's licence and copyright files as its source carries them, and the
`-libraries-source` archive holds their sources.

## Verifying a download

```sh
sha256sum -c SHA256SUMS
gh release verify <tag> --repo DonFalcoF/ffmpeg-lgpl-builds
gh release verify-asset <tag> ffmpeg-n9.0.2-linux64-lgpl.tar.xz --repo DonFalcoF/ffmpeg-lgpl-builds
```

Releases are immutable: a tag cannot move and an asset cannot change while its release exists.
