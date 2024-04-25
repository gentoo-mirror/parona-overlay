# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A Wayland Native VNC Client"
HOMEPAGE="https://github.com/any1/wlvncc"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/any1/wlvncc"
else
	COMMIT="0c1308fbb1e73e3498252ce2238549330d050d04"
	SRC_URI="https://github.com/any1/wlvncc/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64"

# automagic: cyrus-sasl, libgcrypt, lzo, gnutls, libjpeg-turbo, libpng, zlib
RDEPEND="
	dev-libs/aml
	dev-libs/cyrus-sasl:2
	dev-libs/libgcrypt:=
	dev-libs/lzo:2
	dev-libs/openssl
	dev-libs/wayland
	media-libs/libglvnd
	media-libs/libjpeg-turbo:=
	media-libs/libpng
	media-libs/mesa
	media-video/ffmpeg:=
	net-libs/gnutls:=
	sys-libs/zlib
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pixman
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	dev-util/wayland-scanner
"
