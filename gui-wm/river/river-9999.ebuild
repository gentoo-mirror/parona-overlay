# Copyright 2022 Gentoo Authors
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
	ZIG_PIXMAN_COMMIT="d381567de9b6e40dd7f4c6e0b5740f94ebd8c9d7"
	ZIG_WAYLAND_COMMIT="80166ba1d5b4f94c7972d6922587ba769be93f8a"
	ZIG_WLROOTS_COMMIT="49a5f81a71f7b14a3b0e52a5d5d8aa1a9e893bda"
	ZIG_XKBCOMMON_COMMIT="60dde0523907df672ec9ca8b9efb25a1c7ca4d82"

	SRC_URI="
		https://github.com/riverwm/river/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/ifreund/zig-pixman/archive/${ZIG_PIXMAN_COMMIT}.tar.gz -> zig-pixman-${ZIG_PIXMAN_COMMIT}.tar.gz
		https://github.com/ifreund/zig-wayland/archive/${ZIG_WAYLAND_COMMIT}.tar.gz -> zig-wayland-${ZIG_WAYLAND_COMMIT}.tar.gz
		https://github.com/swaywm/zig-wlroots/archive/${ZIG_WLROOTS_COMMIT}.tar.gz -> zig-wlroots-${ZIG_WLROOTS_COMMIT}.tar.gz
		https://github.com/ifreund/zig-xkbcommon/archive/${ZIG_XKBCOMMON_COMMIT}.tar.gz -> zig-xkbcommon-${ZIG_XKBCOMMON_COMMIT}.tar.gz
	"

	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="+man X"

DEPEND="
	dev-libs/libevdev:=
	dev-libs/libinput:=
	dev-libs/wayland
	x11-libs/libxkbcommon
	x11-libs/pixman
	gui-libs/wlroots:0/15
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/zig-0.9
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
		$(usev man -Dman-pages)
		$(usev X -Dxwayland)
	)
	zig_src_compile
}

src_install() {
	zig_src_install

	insinto /etc/xdg/river
	doins example/init

	insinto /usr/share/wayland-sessions
	doins contrib/river.desktop
}
