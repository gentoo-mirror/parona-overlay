# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

COMMIT="d3fb99d6654325ec46277cfdb589f89316bed701"

DESCRIPTION="A Wayland kiosk"
HOMEPAGE="https://www.hjdskes.nl/projects/cage/"
SRC_URI="
	https://github.com/cage-kiosk/cage/archive/${COMMIT}.tar.gz
		-> ${PN}-${COMMIT}.tar.gz
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="X"

# No tests
RESTRICT="test"

DEPEND="
	gui-libs/wlroots:0/17[X=]
	dev-libs/wayland
	>=dev-libs/wayland-protocols-1.14
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
