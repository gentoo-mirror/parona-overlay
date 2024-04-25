# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson multibuild

DESCRIPTION="This library provides single-instance Application classes for various utilities."
HOMEPAGE="https://gitlab.com/desktop-frameworks/utils"
SRC_URI="
	https://gitlab.com/desktop-frameworks/utils/-/archive/v${PV}/utils-v${PV}.tar.bz2
		-> dfl-utils-${PV}.tar.bz2
"
S="${WORKDIR}/utils-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+qt5 qt6"
REQUIRED_USE="|| ( qt5 qt6 )"
RESTRICT="test" # no tests

RDEPEND="
	qt5? (
		dev-qt/qtcore:5
	)
	qt6? (
		dev-qt/qtbase:6
	)
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

pkg_setup() {
	MULTIBUILD_VARIANTS=( qt5 $(usev qt6) )
}

src_configure() {
	myconfigure() {
		local emesonargs=(
			-Duse_qt_version=${MULTIBUILD_VARIANT}
		)
		meson_src_configure
	}

	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant meson_src_compile
}

src_install() {
	multibuild_foreach_variant meson_src_install
	einstalldocs
}
