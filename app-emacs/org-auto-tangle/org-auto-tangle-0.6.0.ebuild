# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

DESCRIPTION="a simple emacs package to allow org file tangling upon save"
HOMEPAGE="https://github.com/yilkalargaw/org-auto-tangle"
SRC_URI="https://github.com/yilkalargaw/org-auto-tangle/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-emacs/async-1.9.3"
BDEPEND="${RDEPEND}"

SITEFILE="50${PN}-gentoo.el"
