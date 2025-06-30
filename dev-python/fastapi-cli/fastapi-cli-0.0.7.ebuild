# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="Run and manage FastAPI apps from the command line with FastAPI CLI"
HOMEPAGE="
	https://github.com/fastapi/fastapi-cli/
	https://pypi.org/project/fastapi-cli/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	!!<dev-python/fastapi-0.115.11[${PYTHON_USEDEP}]
	dev-python/fastapi[${PYTHON_USEDEP}]
	>=dev-python/typer-0.12.3[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.15.0[${PYTHON_USEDEP}]
	>=dev-python/rich-toolkit-0.11.1[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_prepare_all() {
	# clean up coverage
	sed -i -e 's/"-m", "coverage", "run",//' tests/test_cli.py || die

	distutils-r1_python_prepare_all
}
