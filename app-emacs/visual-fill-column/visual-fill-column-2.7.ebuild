# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

DESCRIPTION="Emacs mode for wrapping visual-line-mode buffers at fill-column."
HOMEPAGE="https://codeberg.org/joostkremers/visual-fill-column"
SRC_URI="
	https://codeberg.org/joostkremers/visual-fill-column/archive/${PV}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

SITEFILE="50${PN}-gentoo.el"

elisp-enable-tests ert-runner "${S}/test"
