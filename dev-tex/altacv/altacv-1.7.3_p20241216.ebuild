# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit latex-package

DESCRIPTION="Yet another alternative curriculum vitae/résumé class with LaTeX"
HOMEPAGE="https://github.com/liantze/AltaCV"
COMMIT="cd1e96aa63b49c0c7fb03724e0673d260c99ab41"
SRC_URI="https://github.com/liantze/AltaCV/archive/${COMMIT}.tar.gz -> ${PN}-${COMMIT}.tar.gz"
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
