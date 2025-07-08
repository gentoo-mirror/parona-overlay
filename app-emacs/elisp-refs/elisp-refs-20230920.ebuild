# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

COMMIT="541a064c3ce27867872cf708354a65d83baf2a6d"

DESCRIPTION="Find callers of elisp functions or macros"
HOMEPAGE="
	https://github.com/Wilfred/elisp-refs
	https://melpa.org/#/elisp-refs
"
SRC_URI="
	https://github.com/Wilfred/elisp-refs/archive/${COMMIT}.tar.gz
		-> ${PN}-${COMMIT}.tar.gz
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-emacs/dash-2.12.0
	>=app-emacs/s-1.11.0
"
BDEPEND="test? ( ${RDEPEND} )"

elisp-enable-tests ert "${S}" \
	--load=test/elisp-refs-unit-test.el \
	--funcall=ert-run-tests-batch-and-exit
