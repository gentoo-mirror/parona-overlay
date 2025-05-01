# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

DESCRIPTION="Minimal mode line configuration for Emacs, inspired by doom-modeline"
HOMEPAGE="
	https://git.tty.dog/jessieh/mood-line
	https://gitlab.com/jessieh/mood-line
"
SRC_URI="https://gitlab.com/jessieh/mood-line/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

SITEFILE="50${PN}-gentoo.el"

# https://git.tty.dog/jessieh/mood-line/src/branch/main/ert-test.sh
elisp-enable-tests ert "${S}" \
	--load=test/mood-line-test.el \
	--load=test/mood-line-segment-vc-test.el \
	--funcall=ert-run-tests-batch-and-exit
