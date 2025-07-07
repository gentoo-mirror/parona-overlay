# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

DESCRIPTION="Switch between named 'perspectives' of the editor"
HOMEPAGE="https://github.com/nex3/perspective-el"
SRC_URI="
	https://github.com/nex3/perspective-el/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"
S="${WORKDIR}/perspective-el-2.20"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

SITEFILE="50${PN}-gentoo.el"

elisp-enable-tests ert "${S}" \
	--load=test/test-perspective.el \
	--funcall=ert-run-tests-batch-and-exit
