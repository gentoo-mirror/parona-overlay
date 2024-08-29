# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson multibuild

DESCRIPTION="A Qt-based wrapper for various wayland protocols."
HOMEPAGE="https://gitlab.com/desktop-frameworks/wayqt"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/desktop-frameworks/wayqt"
else
	SRC_URI="
		https://gitlab.com/desktop-frameworks/wayqt/-/archive/v${PV}/wayqt-v${PV}.tar.bz2
	"
	S="${WORKDIR}/${PN}-v${PV}"

	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="+qt5 qt6"
REQUIRED_USE="|| ( qt5 qt6 )"
RESTRICT="test" # no tests

RDEPEND="
	dev-libs/wayland
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwayland:5
	)
	qt6? (
		dev-qt/qtbase:6[gui]
		dev-qt/qtwayland:6
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
	# violates ODR
	filter-lto

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
