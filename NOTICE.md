# Notice

FFmpeg n9.0.2, a reduced LGPL build from BtbN's scripts (BtbN/FFmpeg-Builds, MIT).

The binaries are licensed under the GNU Lesser General Public License, version 3 or later (`COPYING.LGPLv3`, a set of additional permissions on `COPYING.GPLv3`). This software uses code of FFmpeg licensed under the LGPLv3. Each release holds its corresponding source: the `-source` archive (FFmpeg, BtbN's scripts, the build inputs) and the `-libraries-source` archive (every library below, at the commit the build compiled).

## Notices

Copyright and credit lines of the libraries whose licence was read by hand rather than from a common licence text (FreeType's credit line is one its licence requires); every other library's copyright and licence notice is in its licence files under `LICENSES/<stage>/`:

- libpng: Copyright (c) 1995-2026 The PNG Reference Library Authors.
- freetype: Portions of this software are copyright © 2026 The FreeType Project (https://freetype.org). All rights reserved.
- harfbuzz: Copyright (c) 2010-2022 Google, Inc., and the other holders COPYING lists
- pulseaudio: Copyright 2004-2008 Lennart Poettering; Copyright 2006 Pierre Ossman for Cendio AB
- libglvnd: Copyright (c) 2013, NVIDIA CORPORATION.
- vulkan-headers: Copyright 2015-2026 The Khronos Group Inc.
- ffnvcodec: Copyright (c) 2010-2026 NVIDIA Corporation
- glib: Copyright (C) 1995-1997 Peter Mattis, Spencer Kimball and Josh MacDonald
- libdrm: Copyright 1999 Precision Insight, Inc., Cedar Park, Texas; Copyright 2000 VA Linux Systems, Inc., Sunnyvale, California

## Libraries

Linked into the binaries (84): the libraries behind a component the binaries carry, and the libraries those are built against (BtbN's declared dependencies). `LICENSES/<stage>/` holds each one's licence and copyright files as its source carries them.

| Library | Licence | Source | Commit |
| --- | --- | --- | --- |
| libiconv | LGPL-2.1-or-later (the library; the iconv program, GPL-3.0-or-later, is not linked) | https://git.savannah.gnu.org/git/libiconv.git https://git.savannah.gnu.org/git/gnulib.git | `1df3087ba8110c7f3ed3eb5f8869b814dbbe00b0 eb72eb6f75f5621c5d648acd11467fd124584617` |
| zlib | Zlib | https://github.com/madler/zlib.git | `767c4c947852e143f582c85f14cf573411df1b35` |
| fribidi | LGPL-2.1 | https://github.com/fribidi/fribidi.git | `4c914a92e94a9fe4f30ae83a1130099841566448` |
| libogg | BSD-3-Clause | https://github.com/xiph/ogg.git | `06a5e0262cdc28aa4ae6797627a783b5010440f0` |
| libpng | libpng-2.0 | https://github.com/glennrp/libpng.git | `964b4135949703b705fc760fc3fb546b86e5ab47` |
| libxml2 | MIT | https://github.com/GNOME/libxml2.git | `91586dc6742ab335682235120363f6e126eea5e2` |
| openssl | Apache-2.0 | https://github.com/openssl/openssl.git | `openssl-3.6.4` |
| xz | 0BSD (liblzma; the GPL files are scripts and tools, not linked) | https://github.com/tukaani-project/xz.git | `3b1efb04d17c3a9ef7f473d73af13f1531428ffe` |
| brotli | MIT | https://github.com/google/brotli.git | `a3abcbee0d945e51dddeec81e647ffe0cde182c2` |
| freetype | FTL (chosen; FTL OR GPL-2.0-or-later) | https://gitlab.freedesktop.org/freetype/freetype.git | `d333439633039de426f943f28a2926c7f97b5ae5` |
| fontconfig | MIT | https://gitlab.freedesktop.org/fontconfig/fontconfig.git | `bd8f7b597de96761750d0365abb49b19d2f8d5c3` |
| harfbuzz | MIT-Modern-Variant | https://github.com/harfbuzz/harfbuzz.git | `b3bab62307017934dd7f532c52a696fefb12b3ad` |
| freetype | FTL (chosen; FTL OR GPL-2.0-or-later) | https://gitlab.freedesktop.org/freetype/freetype.git | `d333439633039de426f943f28a2926c7f97b5ae5` |
| lcms2 | MIT | https://github.com/mm2/Little-CMS.git | `35cef8775e0ab46f0dda0b46aae1e69d27524432` |
| libffi | MIT (LICENSE-BUILDTOOLS covers build and test tooling only) | https://github.com/libffi/libffi.git | `bc553867367246d140cd156f060bd0409f57f157` |
| libsamplerate | BSD-2-Clause | https://github.com/libsndfile/libsamplerate.git | `0844c208f683527c08ea8a80acc13b398aa9c8bf` |
| libunibreak | Zlib | https://github.com/adah1972/libunibreak.git | `28a2756b864c343f438cd22537d49d394d4666a5` |
| libvorbis | BSD-3-Clause | https://github.com/xiph/vorbis.git | `1b75110b5a2754ba1931d82dd83cb822b266a21d` |
| opencl | Apache-2.0 | https://github.com/KhronosGroup/OpenCL-Headers.git https://github.com/KhronosGroup/OpenCL-ICD-Loader.git | `e6060189f4ebe8b52d885c37af71b9a50c272154 5192c84f8059e5f703e5452929b613f9487f6e4c` |
| pcre2 | BSD-3-Clause | https://github.com/PCRE2Project/pcre2.git | `09eb19dc1102b34e7557408f33318364cb97d2b0` |
| pixman | MIT | https://gitlab.freedesktop.org/pixman/pixman.git | `96c04d1b87934dc4b9396197a2dff737698ab310` |
| pulseaudio | LGPL-2.1-or-later | https://gitlab.freedesktop.org/pulseaudio/pulseaudio.git | `77d25a1e613095bdf87a1d13b65e7c330565077a` |
| vmaf | BSD-2-Clause | https://github.com/Netflix/vmaf.git | `86da14d0306a138fd3f01319860b905169746516` |
| xcbproto | MIT | https://gitlab.freedesktop.org/xorg/proto/xcbproto.git | `cf7e2581b613802f2f8ec2a4b50a6a20aad4bf52` |
| xproto | MIT, MIT-style (X11/HPND) | https://gitlab.freedesktop.org/xorg/proto/xorgproto.git | `fd86fbff46eb7ab8e193c12b8a529e90bae31835` |
| xtrans | MIT | https://gitlab.freedesktop.org/xorg/lib/libxtrans.git | `79f6b0bfe2170496e8c37626043d009f4cd3f1e1` |
| libxau | MIT-style (X11/HPND) | https://gitlab.freedesktop.org/xorg/lib/libxau.git | `be1daeb909f1d678e7859ac1555e90b4e768d5c4` |
| libxcb | MIT | https://gitlab.freedesktop.org/xorg/lib/libxcb.git | `d4e07bab5729c7d7cc3d2b95568cd9a661a53c4f` |
| libx11 | MIT | https://gitlab.freedesktop.org/xorg/lib/libx11.git | `13f9b8de400335f4b86bb0672da02f8166c0e796` |
| libxext | MIT | https://gitlab.freedesktop.org/xorg/lib/libxext.git | `508f8adca2540ff8926ac8456cb1c553a8caae76` |
| libxfixes | MIT | https://gitlab.freedesktop.org/xorg/lib/libxfixes.git | `55bb2d1d57d43e0595ce45393f26eb433d75a7cc` |
| libxi | MIT | https://gitlab.freedesktop.org/xorg/lib/libxi.git | `3a0adabd16d8bf19c772061ad67f25c51281edf3` |
| libxinerama | MIT | https://gitlab.freedesktop.org/xorg/lib/libxinerama.git | `d7162b962710bc724b41cabab4e7cea303c4b541` |
| libxrender | MIT-style (X11/HPND) | https://gitlab.freedesktop.org/xorg/lib/libxrender.git | `f32afe9f877ae032c6bc9c27b17b7978b1b4c856` |
| libxscrnsaver | MIT | https://gitlab.freedesktop.org/xorg/lib/libxscrnsaver.git | `3f753e7a4050db083474444ae91cc17a849eaa4d` |
| libxxf86vm | MIT | https://gitlab.freedesktop.org/xorg/lib/libxxf86vm.git | `c76fde6bffcc87e5dd98d8196bb01a299bdc3236` |
| libxcursor | MIT-style (X11/HPND) | https://gitlab.freedesktop.org/xorg/lib/libxcursor.git | `15efad7ccd035f5d1ddc8d437e047569d1775fa7` |
| libxrandr | MIT-style (X11/HPND) | https://gitlab.freedesktop.org/xorg/lib/libxrandr.git | `8a4ba1974bcf07057cf891128d86ae1ab5303574` |
| libxv | MIT-style (X11/HPND) | https://gitlab.freedesktop.org/xorg/lib/libxv.git | `f315ec50fcad9bdbaed46c3e78dc5e7fe209f933` |
| xxhash | BSD-2-Clause | https://github.com/Cyan4973/xxHash.git | `680bf463fa1ca0461b9a7c2dab7556e1f54cf4cf` |
| vulkan-headers | Apache-2.0 OR MIT | https://github.com/KhronosGroup/Vulkan-Headers.git | `v1.4.363` |
| shaderc | Apache-2.0 | https://github.com/google/shaderc.git | `a8abeb0b8a9d4b11e3d59ca9f4550b8213e733ab` |
| spirv-cross | Apache-2.0, MIT | https://github.com/KhronosGroup/SPIRV-Cross.git | `aa217aeb6c9f0ace7a0ab233b28807edf45eb165` |
| spirv-headers | MIT | https://github.com/KhronosGroup/SPIRV-Headers.git | `2b7475f6d664efbad4d4315c94ecec9640831e5b` |
| amf | MIT | https://github.com/GPUOpen-LibrariesAndSDKs/AMF.git | `6277e353fd625121a8f627b1d0540323ef372a49` |
| aom | BSD-2-Clause | https://aomedia.googlesource.com/aom | `b4ce2cd097b00921b0327bfb5f07b5f8361ade99` |
| dav1d | BSD-2-Clause | https://code.videolan.org/videolan/dav1d.git | `9711965b60bb692ae24004659acf61f5c7d9ed61` |
| ffnvcodec | MIT | https://github.com/FFmpeg/nv-codec-headers.git https://github.com/FFmpeg/nv-codec-headers.git https://github.com/FFmpeg/nv-codec-headers.git | `eddcea9e27f6b772057c9b3f87de2cc1737faffc ced4f8eba3ba5dd431932cba17928f0dffdaeb2b 833faee5f7b8d3f56444347c587f4aed11ee213f` |
| kvazaar | BSD-3-Clause | https://github.com/ultravideo/kvazaar.git | `2b06691bb5844404c0e703f12a5d7b0fee914ec7` |
| lcevcdec | BSD-3-Clause | https://github.com/v-novaltd/LCEVCdec.git | `17804ac54db8fbb42717f3275b1e73f3c0b067d3` |
| libaribb24 | LGPL-3.0 | https://github.com/nkoriyama/aribb24.git | `5e9be272f96e00f15a2f3c5f8ba7e124862aec38` |
| libaribcaption | MIT | https://github.com/xqq/libaribcaption.git | `c64c23b8905ba514b87c9789269e9f66f949ffe0` |
| libass | ISC | https://github.com/libass/libass.git | `f61db567e6593df3470e91594bcd4ad2d0473aff` |
| libjxl | BSD-3-Clause | https://github.com/libjxl/libjxl.git | `b87738951c1254cd8cccaa6d47712ba735da56d8` |
| libmp3lame | LGPL-2.0 | https://svn.code.sf.net/p/lame/svn/trunk/lame | `6835` |
| libopus | BSD-3-Clause | https://github.com/xiph/opus.git | `503d81b138d76621aae4b12786e90de48aa8db3a` |
| libplacebo | LGPL-2.1 | https://code.videolan.org/videolan/libplacebo.git | `1937beef3a2f508266c68efea1491e3fc4600e04` |
| glib | LGPL-2.1-or-later | https://github.com/GNOME/glib.git | `5a124d1e66a6c2dc56989303b4d6d4781c2952ed` |
| cairo | LGPL-2.1 | https://gitlab.freedesktop.org/cairo/cairo.git | `74755964edef651691d5cd36ff140108298e4e6e` |
| pango | LGPL-2.0 | https://github.com/GNOME/pango.git | `8e74c27c113c98664b77272d16b14bbce542c184` |
| librsvg | LGPL-2.1 | https://github.com/GNOME/librsvg.git | `7612431eb02dc009319094f8513d63c1faaecfb4` |
| libtheora | BSD-3-Clause | https://github.com/xiph/theora.git | `28fd5ec77f0ad0e07a371cef1047828116f6bd8a` |
| libvpx | BSD-3-Clause | https://chromium.googlesource.com/webm/libvpx | `5e680f30801d03c21078f8c4b772464752516211` |
| libwebp | BSD-3-Clause | https://chromium.googlesource.com/webm/libwebp | `5c168cd23b1872969c38e34b01b04dcf29849288` |
| libzmq | MPL-2.0 | https://github.com/zeromq/libzmq.git | `46493370217ac135246617fa2f6ac819d8b61bfc` |
| lv2 | Apache-2.0, ISC, MIT, MIT-style (X11/HPND) | https://github.com/lv2/lv2.git | `3c57dae600a5ad8d05acd53ee3490f7d91cb7be6` |
| serd | BSD-3-Clause, ISC | https://github.com/drobilla/serd.git | `b6053bb2a4533e6a8e3821c1061f140d5e666938` |
| zix | ISC | https://github.com/drobilla/zix.git | `17d632393f5addb6fa24dda2927b96515407cca7` |
| sord | BSD-3-Clause, ISC | https://github.com/drobilla/sord.git | `4b5232bb91e7f2f1b84df384494d073fabbcd312` |
| sratom | ISC | https://github.com/lv2/sratom.git | `9e8ee84eed502e6030ce8bb49694fd28542b08fc` |
| lilv | ISC | https://github.com/lv2/lilv.git | `4b8f30055fa5cb4134a2eb45fc1555bc04289314` |
| onevpl | MIT | https://github.com/intel/libvpl.git | `674d015bcb294bc39fa276e99a652ea045423e82` |
| opencore-amr | Apache-2.0 | https://git.code.sf.net/p/opencore-amr/code | `7dba8c32238418ce0b316a852b2224df586ca896` |
| openh264 | BSD-2-Clause | https://github.com/cisco/openh264.git | `8b2d28faade10d74d99ac80e199aef664c9c5a3b` |
| openjpeg | BSD-2-Clause | https://github.com/uclouvain/openjpeg.git | `8314119b067c0fc77834731168daaebd379fdb12` |
| rav1e | BSD-2-Clause | https://github.com/xiph/rav1e.git | `31435de9d76fddd38f6dcc31d4014574cebb2092` |
| sdl | Zlib | https://github.com/libsdl-org/SDL.git | `b90ac95029d801c5abc59472ba8e2200dff31e1e` |
| snappy | BSD-3-Clause | https://github.com/google/snappy.git | `9c28114a38866f6deeaa826db918293bc28ae410` |
| soxr | LGPL-2.1 | https://git.code.sf.net/p/soxr/code | `945b592b70470e29f917f4de89b4281fbbd540c0` |
| svtav1 | BSD-2-Clause, BSD-3-Clause | https://gitlab.com/AOMediaCodec/SVT-AV1.git | `5ed9ffbcb5086da23f30fe9bc5b00145358462da` |
| twolame | LGPL-2.1 | https://github.com/njh/twolame.git | `6fced852d4d5cfad58cf9dbe3ea619b08e87d398` |
| uavs3d | BSD-3-Clause | https://github.com/uavs3/uavs3d.git | `0e20d2c291853f196c68922a264bcd8471d75b68` |
| vvenc | BSD-3-Clause | https://github.com/fraunhoferhhi/vvenc.git | `b1cfb2ad495af6ae4cc214b7a060e8b4166c4629` |
| zimg | WTFPL | https://github.com/sekrit-twc/zimg.git | `67e0603271c080e22c8429856dd4a8a56587e61e` |

Also in the libraries-source archive, built against but not linked (6):

| Library | Licence | Source | Commit | Why not linked |
| --- | --- | --- | --- | --- |
| xorg-macros | MIT | https://gitlab.freedesktop.org/xorg/util/macros.git | `ea1e15a4909ac8b03b2c5a08ac3810b385985157` | autoconf macros, used only to configure the X11 libraries |
| libglvnd | MIT AND BSD-1-Clause | https://gitlab.freedesktop.org/glvnd/libglvnd.git | `c046a760d845416e98ac4128757b2b356c47fdaa` | no string of it in any binary; OpenGL is loaded at run time |
| vulkan-loader | MIT | https://github.com/BtbN/Vulkan-Shim-Loader.git https://github.com/KhronosGroup/Vulkan-Headers.git | `65b3936528cd92eb4ea3de485d03f858a3850484 v1.4.363` | loaded at run time from the host (dlopen of libvulkan.so.1) |
| libpciaccess | MIT | https://gitlab.freedesktop.org/xorg/lib/libpciaccess.git | `38e6f15f839fba2c49982e7ad61cde681fd5d4d6` | a dependency of libdrm only, which is loaded at run time |
| libdrm | MIT | https://gitlab.freedesktop.org/mesa/drm.git | `b97cbde15c5c3abfe44d78e8f57139e50f612fec` | loaded at run time from the host (implib-gen trampoline for libdrm) |
| libva | MIT | https://github.com/intel/libva.git | `6b07f7100512817f736967e899b8c26313c20623` | loaded at run time from the host (implib-gen trampolines for libva, libva-drm, libva-x11) |
