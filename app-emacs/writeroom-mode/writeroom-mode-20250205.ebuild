# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

DESCRIPTION="Writeroom-mode: distraction-free writing for Emacs."
HOMEPAGE="https://github.com/joostkremers/writeroom-mode"
COMMIT="cca2b4b3cfcfea1919e1870519d79ed1a69aa5e2"
SRC_URI="
	https://github.com/joostkremers/writeroom-mode/archive/${COMMIT}.tar.gz
		-> ${PN}-${COMMIT}.tar.gz
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-emacs/visual-fill-column"

SITEFILE="50${PN}-gentoo.el"

elisp-enable-tests ert-runner "${S}/test"
