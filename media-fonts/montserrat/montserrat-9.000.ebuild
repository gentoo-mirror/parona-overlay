# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Montserrat font"
HOMEPAGE="https://github.com/JulietaUla/Montserrat"
SRC_URI="
	https://github.com/JulietaUla/Montserrat/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/Montserrat-${PV}/"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="otf"

RESTRICT="test" # tests not applicable downstream

src_compile() {
	:;
}

src_install() {
	FONT_S="${S}/fonts/ttf" FONT_SUFFIX="ttf" font_src_install
	use otf && FONT_S="${S}/fonts/otf" FONT_SUFFIX="otf" font_src_install
}
