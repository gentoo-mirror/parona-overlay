# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson multibuild

DESCRIPTION="DFL Login1 class implements a part of the systemd logind dbus protocol."
HOMEPAGE="https://gitlab.com/desktop-frameworks/login1"
SRC_URI="
	https://gitlab.com/desktop-frameworks/login1/-/archive/v${PV}/login1-v${PV}.tar.bz2
		-> dfl-login1-${PV}.tar.bz2
"
S="${WORKDIR}/login1-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+qt5 qt6"
REQUIRED_USE="|| ( qt5 qt6 )"
RESTRICT="test" # no tests

RDEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
	)
	qt6? (
		dev-qt/qtbase:6[dbus]
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
