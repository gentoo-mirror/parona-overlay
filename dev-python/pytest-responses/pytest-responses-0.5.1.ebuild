# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="py.test integration for responses"
HOMEPAGE="https://github.com/getsentry/pytest-responses"
SRC_URI="
	https://github.com/getsentry/pytest-responses/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pytest-2.5[${PYTHON_USEDEP}]
	dev-python/responses[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( ${PN} )
EPYTEST_PLUGIN_AUTOLOAD=1
distutils_enable_tests pytest
