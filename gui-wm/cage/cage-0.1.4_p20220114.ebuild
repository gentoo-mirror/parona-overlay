# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A Wayland kiosk"
HOMEPAGE="https://www.hjdskes.nl/projects/cage/"
COMMIT="f71844ab54dbb3192d8c2f0a1db84d50e18536d9"
SRC_URI="https://github.com/cage-kiosk/cage/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+man X"

DEPEND="
	gui-libs/wlroots:0/15[X?]
	dev-libs/wayland
	>=dev-libs/wayland-protocols-1.14
	x11-libs/libxkbcommon
	x11-libs/pixman
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/wayland-scanner
	man? ( >=app-text/scdoc-1.9.2 )
"

src_prepare() {
	sed -i "s/\(if scdoc.found()\)/\1 and get_option('man-pages').enabled()/" meson.build || die
	default
}

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
		$(meson_use X xwayland)
	)
	meson_src_configure
}
