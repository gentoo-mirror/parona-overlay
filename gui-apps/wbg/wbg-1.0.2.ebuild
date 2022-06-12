# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Super simple wallpaper application for Wayland compositors"
HOMEPAGE="https://codeberg.org/dnkl/wbg"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/wbg"
else
	SRC_URI="https://codeberg.org/dnkl/wbg/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="+png +jpeg"
REQUIRED_USE="|| ( png jpeg )"

DEPEND="
	x11-libs/pixman
	dev-libs/wayland-protocols
	dev-libs/wayland
	>=dev-libs/tllist-1.0.1
	png? ( media-libs/libpng )
	jpeg? ( media-libs/libjpeg-turbo )
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/wayland-scanner
"

src_configure() {
	local emesonargs=(
		$(meson_feature png)
		$(meson_feature jpeg)
	)
	meson_src_configure
}
