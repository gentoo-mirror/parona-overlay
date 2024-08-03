# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

QT_MIN="5.8.0"

DESCRIPTION="GUI for Fancontrol."
HOMEPAGE="https://github.com/Maldela/Fancontrol-GUI"
COMMIT="12c5e7eea33ea1cc6feebf0a504d3de231a931ee"
SRC_URI="
	https://github.com/Maldela/fancontrol-gui/archive/${COMMIT}.tar.gz
		-> ${PN}-${COMMIT}.tar.gz
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="systemd test"

RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-qt/qtcore-${QT_MIN}:5
	>=dev-qt/qtwidgets-${QT_MIN}:5
	>=dev-qt/qtgui-${QT_MIN}:5
	>=dev-qt/qtdeclarative-${QT_MIN}:5
	kde-frameworks/kauth:5
	kde-frameworks/kconfig:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kdbusaddons:5
	kde-frameworks/kdeclarative:5
	kde-frameworks/ki18n:5
	kde-frameworks/knotifications:5
	kde-frameworks/kpackage:5
	kde-plasma/libplasma:5
	systemd? (
		>=dev-qt/qtdbus-${QT_MIN}:5
	)
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-qt/qttest-${QT_MIN}:5
	)
"
BDEPEND="
	>=kde-frameworks/extra-cmake-modules-5.38
"

src_configure() {
	local mycmakeargs=(
		-DNO_SYSTEMD=$(usex !systemd)
		-DBUILD_GUI=ON
		-DBUILD_KCM=$(usex systemd)
		-DBUILD_PLASMOID=ON
		-DBUILD_HELPER=ON
		-DINSTALL_SHARED=ON
		-DINSTALL_POLKIT=ON
		-DBUILD_TESTING=$(usex test)
	)

	cmake_src_configure
}
