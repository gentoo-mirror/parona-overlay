# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit latex-package

DESCRIPTION="Yet another alternative curriculum vitae/résumé class with LaTeX"
HOMEPAGE="https://github.com/liantze/AltaCV"
COMMIT="a41572b0e46c0b390c25f12b6042d0a7145ee3ce"
SRC_URI="https://github.com/liantze/AltaCV/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/AltaCV-${COMMIT}"

LICENSE="LPPL-1.3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

DEPEND="
	dev-tex/biber
	dev-texlive/texlive-latex
	dev-texlive/texlive-fontsextra
"
RDEPEND="${DEPEND}"
