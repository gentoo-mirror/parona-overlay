# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Create and update inline snapshots in your python tests"
HOMEPAGE="
	https://15r10nk.github.io/inline-snapshot/
	https://github.com/15r10nk/inline-snapshot/
	https://pypi.org/project/inline-snapshot/
"
SRC_URI="
	https://github.com/15r10nk/inline-snapshot/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/asttokens-2.0.5[${PYTHON_USEDEP}]
	>=dev-python/black-23.3.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.4[${PYTHON_USEDEP}]
	>=dev-python/executing-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.7.1[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/dirty-equals-0.7.0[${PYTHON_USEDEP}]
		>=dev-python/hypothesis-6.75.5[${PYTHON_USEDEP}]
		>=dev-python/mypy-1.2.0[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		>=dev-python/pytest-subtests-0.11.0[${PYTHON_USEDEP}]
		>=dev-python/time-machine-2.10.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	# TODO: package
	#>=dev-python/pyright-1.1.359[${PYTHON_USEDEP}]
	"tests/test_typing.py::test_typing[pyright]"
)
EPYTEST_XDIST=1
distutils_enable_tests pytest

src_prepare() {
	default

	sed -i -e 's/project.run(\(.*\))/project.run(\1, "-p no:asyncio", "-p no:aiohttp")/' tests/test_xdist.py || die
	sed -i \
		-e '/^def test_disable_option/,/^def test_black_config/ {
			s/project.run(\(.*\))/project.run(\1, "-p no:asyncio", "-p no:aiohttp")/
		}' tests/test_pytest_plugin.py || die
}

python_test() {
	epytest -p no:asyncio -p no:aiohttp
}
