# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_MAX_VERSION="0.11"
ZIG_MIN_VERSION="0.11"
inherit zig

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://codeberg.org/river/river/"

if [[ "${PV}" == "9999" ]];  then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/river/river/"
	EGIT_SUBMODULES=( "*" )
else
	SRC_URI="
		https://codeberg.org/river/river/releases/download/v${PV}/${P}.tar.gz
	"

	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="X +man"

RESTRICT="test" # no tests

CDEPEND="
	dev-libs/libevdev
	dev-libs/libinput:=
	dev-libs/wayland
	media-libs/libdisplay-info
	x11-libs/libxkbcommon[X?,wayland]
	x11-libs/pixman
	gui-libs/wlroots:0/17[X?]
"
DEPEND="${CDEPEND}
	dev-libs/wayland-protocols
"
RDEPEND="${CDEPEND}"
BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
	man? ( app-text/scdoc )
"

src_compile() {
	local ezigargs=(
		-Dxwayland=$(usex X true false)
		-Dman-pages=$(usex man true false)
		-Dbash-completion=true
		-Dzsh-completion=true
		-Dfish-completion=true
	)
	zig_src_compile
}

src_install() {
	zig_src_install

	insinto /usr/share/examples/river
	doins example/init

	insinto /usr/share/wayland-sessions
	doins contrib/river.desktop
}
