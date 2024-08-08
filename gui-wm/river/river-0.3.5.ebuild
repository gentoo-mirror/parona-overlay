# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_MAX_VERSION="0.13"
ZIG_MIN_VERSION="0.13"

# build.zig.zon
declare -A ZIG_VENDOR=(
	[zig-pixman]="https://codeberg.org/ifreund/zig-pixman/archive/v0.2.0.tar.gz"
	[zig-wayland]="https://codeberg.org/ifreund/zig-wayland/archive/v0.2.0.tar.gz"
	[zig-wlroots]="https://codeberg.org/ifreund/zig-wlroots/archive/v0.18.0.tar.gz"
	[zig-xkbcommon]="https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.2.0.tar.gz"
)

inherit zig

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://codeberg.org/river/river/"
SRC_URI="
	https://codeberg.org/river/river/releases/download/v${PV}/${P}.tar.gz
	${ZIG_VENDOR_URIS}
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="X +man"

RESTRICT="test" # no tests

CDEPEND="
	dev-libs/libevdev
	dev-libs/libinput:=
	dev-libs/wayland
	x11-libs/libxkbcommon[X?,wayland]
	x11-libs/pixman
	gui-libs/wlroots:0.18[X?]
"
DEPEND="${CDEPEND}
	dev-libs/wayland-protocols
	media-libs/libdisplay-info
"
RDEPEND="${CDEPEND}"
BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
	man? ( app-text/scdoc )
"

QA_FLAGS_IGNORED=".*"

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
