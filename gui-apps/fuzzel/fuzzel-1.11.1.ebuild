# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Application launcher for wlroots based Wayland compositors."
HOMEPAGE="https://codeberg.org/dnkl/fuzzel"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/fuzzel"
else
	SRC_URI="https://codeberg.org/dnkl/fuzzel/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"

	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

# Nanosvg is enabled by default by upstream, but cairo is enabled by default by desktop profile.
IUSE="+cairo +svg +png nanosvg"
RESTRICT="test" # no tests

REQUIRED_USE="
	cairo? ( !nanosvg )
	svg? ( ^^ ( cairo nanosvg ) )
"

CDEPEND="
	dev-libs/wayland
	>=media-libs/fcft-3.0.0
	<media-libs/fcft-4.0.0
	media-libs/fontconfig
	x11-libs/libxkbcommon
	x11-libs/pixman
	cairo? (
		dev-libs/glib:2
		x11-libs/cairo
	)
	nanosvg? ( media-libs/nanosvg )
	png? ( media-libs/libpng:= )
	svg? (
		!nanosvg? ( gnome-base/librsvg:2 )
	)
"
DEPEND="${CDEPEND}
	>=dev-libs/tllist-1.0.1
	>=dev-libs/wayland-protocols-1.32
"
RDEPEND="${CDEPEND}"
BDEPEND="
	app-text/scdoc
	dev-util/wayland-scanner
"

src_prepare() {
	sed -i "s/'doc', '${PN}'/'doc', '${PF}'/" meson.build || die
	default
}

src_configure() {
	local emesonargs=(
		$(meson_feature cairo enable-cairo)
		-Dpng-backend=$(usex png libpng none)
		-Dsvg-backend=$(usex svg $(usex nanosvg nanosvg librsvg) none)
	)
	use nanosvg && emesonargs+=( -Dsystem-nanosvg=enabled )
	meson_src_configure
}
