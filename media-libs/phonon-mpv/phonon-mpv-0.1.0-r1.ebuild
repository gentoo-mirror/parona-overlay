# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Phonon Backend using MPV Player(libmpv)"
HOMEPAGE="https://github.com/OpenProgger/phonon-mpv"
SRC_URI="
	https://github.com/OpenProgger/phonon-mpv/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,opengl,widgets,X]
	>=media-libs/phonon-4.12.0[qt6(+)]
	>=media-video/mpv-0.29.0:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DQT_MAJOR_VERSION=6
		-DPHONON_BUILD_QT6=ON
		-DPHONON_BUILD_QT5=OFF
	)
	cmake_src_configure
}
