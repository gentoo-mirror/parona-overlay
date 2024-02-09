# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://github.com/riverwm/river"

if [[ "${PV}" == "9999" ]];  then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/riverwm/river"
	EGIT_SUBMODULES=( "*" )
else
	ZIG_PIXMAN_COMMIT="b0a961079d80059ef56565e23c5f7a8b6a911196"
	ZIG_WAYLAND_COMMIT="b9c6fcb8cab3a85c5583ef371055cb589b1e7b18"
	ZIG_WLROOTS_COMMIT="46c81cd6f7cbd57c4362d547e72408a65c6d7d84"
	ZIG_XKBCOMMON_COMMIT="e93ceb0436c66a7e4c727fdb59020e889519e489"

	SRC_URI="
		https://github.com/riverwm/river/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/ifreund/zig-pixman/archive/${ZIG_PIXMAN_COMMIT}.tar.gz
			-> zig-pixman-${ZIG_PIXMAN_COMMIT}.tar.gz
		https://github.com/ifreund/zig-wayland/archive/${ZIG_WAYLAND_COMMIT}.tar.gz
			-> zig-wayland-${ZIG_WAYLAND_COMMIT}.tar.gz
		https://github.com/swaywm/zig-wlroots/archive/${ZIG_WLROOTS_COMMIT}.tar.gz
			-> zig-wlroots-${ZIG_WLROOTS_COMMIT}.tar.gz
		https://github.com/ifreund/zig-xkbcommon/archive/${ZIG_XKBCOMMON_COMMIT}.tar.gz
			-> zig-xkbcommon-${ZIG_XKBCOMMON_COMMIT}.tar.gz
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
	x11-libs/libxkbcommon[X?,wayland]
	x11-libs/pixman
	gui-libs/wlroots:0/16[X?]
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

src_prepare() {
	if [[ "${PV}" != "9999" ]] ; then
		rmdir deps/zig-{pixman,wayland,wlroots,xkbcommon} || die
		pushd "${WORKDIR}" > /dev/null
		mv "zig-pixman-${ZIG_PIXMAN_COMMIT}" "${S}/deps/zig-pixman" || die
		mv "zig-wayland-${ZIG_WAYLAND_COMMIT}" "${S}/deps/zig-wayland" || die
		mv "zig-wlroots-${ZIG_WLROOTS_COMMIT}" "${S}/deps/zig-wlroots" || die
		mv "zig-xkbcommon-${ZIG_XKBCOMMON_COMMIT}" "${S}/deps/zig-xkbcommon" || die
		pushd > /dev/null
	fi

	default_src_prepare
}

src_compile() {
	local ezigargs=(
		$(usev X -Dxwayland)
		$(usev man -Dman-pages)
		-Dbash-completion
		-Dzsh-completion
		-Dfish-completion
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
