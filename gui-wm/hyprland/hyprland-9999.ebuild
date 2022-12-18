# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PN="${PN^}"
MY_PV="${PV/_/}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="A dynamic tiling Wayland compositor that doesn't sacrifice on its looks."
HOMEPAGE="https://github.com/hyprwm/Hyprland"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hyprwm/Hyprland"
	EGIT_SUBMODULES=( 'wlroots' )
else
	SRC_URI="https://github.com/hyprwm/${MY_PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64"
fi

LICENSE="BSD"
SLOT="0"

IUSE="X"

DEPEND="
	gui-libs/wlroots[X?]
	X? (
		x11-libs/libxcb
	)
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local emesonargs=(
		$(meson_feature X xwayland)
	)
	meson_src_configure
}
