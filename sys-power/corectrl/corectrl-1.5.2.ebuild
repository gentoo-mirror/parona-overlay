# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Profile based system control utility"
HOMEPAGE="https://gitlab.com/corectrl/corectrl"
SRC_URI="
	https://gitlab.com/corectrl/corectrl/-/archive/v${PV}/corectrl-v${PV}.tar.bz2
		-> ${P}.tar.bz2
"
S="${WORKDIR}/corectrl-v${PV}"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

# Bundled with too restrictive version requirements:
# units (MIT)
RDEPEND="
	>=dev-libs/libfmt-5:=
	dev-libs/botan:3=
	dev-libs/glib:2
	>=dev-libs/quazip-1.0:=[qt6(+)]
	>=dev-libs/spdlog-1.4:=
	>=dev-libs/pugixml-1.11
	>=dev-qt/qtbase-6.8:6[dbus,network,widgets]
	>=dev-qt/qtdeclarative-6.8:6[svg]
	>=dev-qt/qtcharts-6.8:6
	>=dev-qt/qtsvg-6.8:6
	sys-auth/polkit
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-cpp/catch-3:0
		>=dev-cpp/trompeloeil-40
	)
"
BDEPEND="
	>=dev-qt/qttools-6.8:6[linguist]
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)

	cmake_src_configure
}
