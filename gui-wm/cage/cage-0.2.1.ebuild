# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A Wayland kiosk"
HOMEPAGE="https://www.hjdskes.nl/projects/cage/"
SRC_URI="
	https://github.com/cage-kiosk/cage/releases/download/v${PV}/${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="X"

# No tests
RESTRICT="test"

DEPEND="
	dev-libs/wayland
	>=dev-libs/wayland-protocols-1.14
	gui-libs/wlroots:0.19[X=]
	x11-libs/libxkbcommon
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/wayland-scanner
	>=app-text/scdoc-1.9.2
"

src_configure() {
	local emesonargs=(
		-Dman-pages=enabled
	)
	meson_src_configure
}
