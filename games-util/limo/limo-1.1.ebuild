# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A simple Qt based mod manager"
HOMEPAGE="https://github.com/limo-app/limo/"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/limo-app/limo/"
else
	SRC_URI="
		https://github.com/limo-app/limo/archive/refs/tags/v${PV}.tar.gz
			-> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/libarchive:=
	app-arch/lz4:=
	app-arch/unrar:=
	app-arch/zstd:=
	dev-cpp/cpr
	dev-cpp/libloot:0/0.24
	dev-libs/jsoncpp:=
	dev-libs/openssl:=
	dev-libs/pugixml
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	sys-libs/zlib
"
DEPEND="
	${RDEPEND}
	test? (
		dev-cpp/catch
	)
"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/limo-1.1-hookup-tests.ebuild
	"${FILESDIR}"/limo-1.1-gcc15-numeric.patch
)

src_configure() {
	local mycmakeargs=(
		-DIS_FLATPAK=OFF
		-DUSE_SYSTEM_LIBUNRAR=ON
		-DLIMO_INSTALL_PREFIX="${EPREFIX}/usr"
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}

src_test() {
	cmake_src_test -j1
}
