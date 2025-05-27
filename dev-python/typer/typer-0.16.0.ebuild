# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
EPYTEST_XDIST=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Typer, build great CLIs. Easy to code. Based on Python type hints."
HOMEPAGE="
	https://github.com/fastapi/typer/
	https://pypi.org/project/typer/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/click-8.0.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4.3[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/rich-10.11.0[${PYTHON_USEDEP}]
		>=dev-python/shellingham-1.3.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	# clean up coverage
	sed -i \
		-e 's/"-m", "coverage", "run",//' \
		-e 's/-m coverage run//' \
		-e '/"-m",/ {
			N
			N
			s/"-m",\n.*"coverage",\n.*"run",//
		}' $(find tests -name "test_*.py") || die

	distutils-r1_python_prepare_all
}

python_test() {
	# See scripts/tests.sh
	local -x TERMINAL_WIDTH=3000 _TYPER_FORCE_DISABLE_TERMINAL=1  _TYPER_RUN_INSTALL_COMPLETION_TESTS=1

	epytest
}
