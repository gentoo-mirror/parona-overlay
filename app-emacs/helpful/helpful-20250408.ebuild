# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

COMMIT="03756fa6ad4dcca5e0920622b1ee3f70abfc4e39"

DESCRIPTION="A better Emacs *help* buffer"
HOMEPAGE="
	https://github.com/Wilfred/helpful
	https://melpa.org/#/helpful
"
SRC_URI="
	https://github.com/Wilfred/helpful/archive/${COMMIT}.tar.gz
		-> ${PN}-${COMMIT}.tar.gz
	test? (
		mirror://gnu/emacs/emacs-25.3.tar.gz
	)
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-emacs/dash-2.18.0
	>=app-emacs/s-1.11.0
	>=app-emacs/f-0.20.0
	>=app-emacs/elisp-refs-1.2
"
BDEPEND="test? ( ${RDEPEND} )"

SITEFILE="50${PN}-gentoo.el"

elisp-enable-tests ert "${S}" \
	--load=test/helpful-unit-test.el \
	--funcall=ert-run-tests-batch-and-exit

src_prepare() {
	default
	if use test; then
		mv "${WORKDIR}"/emacs-25.3 "${S}"/emacs-25.3 || die
	fi
}
