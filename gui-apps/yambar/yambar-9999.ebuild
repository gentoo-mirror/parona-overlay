# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Modular status panel for X11 and Wayland, inspired by polybar"
HOMEPAGE="https://codeberg.org/dnkl/yambar"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/yambar"
else
	SRC_URI="https://codeberg.org/dnkl/yambar/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"

	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="mpd shared wayland X"

# e-poll-shim, libinotify, xcb-errors
DEPEND="
	dev-libs/libyaml
	>=dev-libs/tllist-1.0.1
	>=media-libs/fcft-3.0.0
	<media-libs/fcft-4.0.0
	x11-libs/pixman
	mpd? (
		media-libs/libmpd
	)
	wayland? (
		dev-libs/wayland
	)
	X? (
		x11-libs/libxcb
		x11-libs/xcb-util
		x11-libs/xcb-util-cursor
		x11-libs/xcb-util-wm
	)
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i "/install_data/,/install_dir/ s/'${PN}'/'${PF}'/" meson.build || die
	use mpd || sed -i '/- mpd:/,+2 d' test/full-conf-good.yml || die
	default
}

src_configure() {
	local emesonargs=(
		$(meson_feature mpd plugin-mpd)
		$(meson_use shared core-plugins-as-shared-libraries)
		$(meson_feature wayland backend-wayland)
		$(meson_feature X backend-x11)
	)
	meson_src_configure
}
