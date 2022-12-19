# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig

DESCRIPTION="stacktile is a layout generator for the river Wayland compositor."
HOMEPAGE="https://sr.ht/~leon_plickat/stacktile/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~leon_plickat/stacktile"
else
	ZIG_WAYLAND_COMMIT="f64abbd016a918fe6e74e0cf337410cecad5eb5d"
	SRC_URI="
		https://git.sr.ht/~leon_plickat/stacktile/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/ifreund/zig-wayland/archive/${ZIG_WAYLAND_COMMIT}.tar.gz
			-> zig-wayland-${ZIG_WAYLAND_COMMIT}.tar.gz
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

# No tests
RESTRICT="test"

CDEPEND="
	dev-libs/wayland
"
DEPEND="
	${CDEPEND}
	dev-libs/wayland-protocols
"
RDEPEND="
	${CDEPEND}
	gui-wm/river
"
BDEPEND="
	dev-util/wayland-scanner
"

src_prepare() {
	if [[ "${PV}" != "9999" ]]; then
		rmdir deps/zig-wayland || die
		mv "${WORKDIR}/zig-wayland-${ZIG_WAYLAND_COMMIT}" deps/zig-wayland || die
	fi

	eapply_user
}
