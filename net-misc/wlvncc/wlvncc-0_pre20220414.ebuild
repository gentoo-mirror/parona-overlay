# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A Wayland Native VNC Client"
HOMEPAGE="https://github.com/any1/wlvncc"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/any1/wlvncc"
else
	COMMIT="b725a08b47e3264366b90eb74ea0e823e1bfd9a4"
	SRC_URI="https://github.com/any1/wlvncc/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/aml
	dev-libs/wayland
	media-video/ffmpeg
	media-libs/libglvnd
	media-libs/mesa
	>=net-libs/libvncserver-0.9.13_p20201130
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pixman
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/wayland-scanner
"
