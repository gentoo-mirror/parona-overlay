# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit python-any-r1 meson

DESCRIPTION="A simple library for font loading and glyph rasterization"
HOMEPAGE="https://codeberg.org/dnkl/fcft"
SRC_URI="https://codeberg.org/dnkl/fcft/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples +man test +text-shaping"

RESTRICT="!test? ( test )"

COMMON_DEPEND="
	>=dev-libs/tllist-1.0.1
	media-libs/fontconfig
	media-libs/freetype:2
	x11-libs/pixman
	text-shaping? (
		dev-libs/libutf8proc
		media-libs/harfbuzz
	)
"
DEPEND="
	${COMMON_DEPEND}
	test? (
		dev-libs/check
		|| (
			media-fonts/noto-emoji
			app-i18n/unicode-emoji
		)
	)
"
RDEPEND="${COMMON_DEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	man? ( app-text/scdoc )
"

S="${WORKDIR}/${PN}"

src_prepare() {
	default

	sed -i "/install_data/,/install_dir/ s/${PN}/${PF}/" meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature text-shaping grapheme-shaping)
		$(meson_feature text-shaping run-shaping)
		$(meson_use examples examples)
		$(use text-shaping && meson_use test test-text-shaping)
	)
	meson_src_configure
}
