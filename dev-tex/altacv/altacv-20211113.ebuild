# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit latex-package

DESCRIPTION="Yet another alternative curriculum vitae/résumé class with LaTeX"
HOMEPAGE="https://github.com/Titan-C/AltaCV"
COMMIT="81a2b47d160976e4efccd93402eaf36c1985537a"
SRC_URI="https://github.com/liantze/AltaCV/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/AltaCV-${COMMIT}"

LICENSE="LPPL-1.3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-tex/biber
	dev-texlive/texlive-latex
	dev-texlive/texlive-fontsextra
"
RDEPEND="${DEPEND}"
BDEPEND=""
