# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="Rich toolkit for building command-line applications"
HOMEPAGE="
	https://github.com/patrick91/rich-toolkit/
	https://pypi.org/project/rich-toolkit/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/click-8.1.7[${PYTHON_USEDEP}]
	>=dev-python/rich-13.7.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.12.2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/inline-snapshot-0.12.1[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
