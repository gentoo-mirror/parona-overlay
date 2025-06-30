# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin for testing Python code examples in docstrings and markdown files."
HOMEPAGE="
	https://pypi.org/project/pytest-examples/
	https://github.com/pydantic/pytest-examples/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/black[${PYTHON_USEDEP}]
	>=dev-python/pytest-8.3.4[${PYTHON_USEDEP}]
	dev-util/ruff
"

PATCHES=(
	"${FILESDIR}/pytest-examples-0.0.14-revert-use-of-ruff-module.patch"
)

EPYTEST_PLUGINS=()
EPYTEST_PLUGIN_AUTOLOAD=1
distutils_enable_tests pytest
