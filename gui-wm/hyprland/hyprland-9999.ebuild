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

src_prepare() {
	eapply_user
	#sed -i "s/install: true/install: not meson.is_subproject()/" subprojects/wlroots/meson.build || die
	#sed -i "s/pkgconfig.generate/not meson.is_subproject() ? pkgconfig.generate/" subprojects/wlroots/include/meson.build || die
	#sed -i "s/install_subdir/not meson.is_subproject() ? install_subdir/" subprojects/wlroots/include/meson.build || die
	#sed -i "s/subproject('wlroots',.*$/dependency('wlroots')/" meson.build || die
	#sed -i "s/wlroots.get_variable('features').get('xwayland')/wlroots.get_variable(pkgconfig: 'have_xwayland') == 'true'/" meson.build || die
	#sed -i "s/.get_variable('wlroots')//" src/meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature X xwayland)
	)
	meson_src_configure
}
