# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="CLI tool and Python library to configure SteelSeries gaming mice"
HOMEPAGE="https://flozz.github.io/rivalcfg/"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/hidapi-0.14.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
	)
"

distutils_enable_tests pytest

python_test() {
	local -x RIVALCFG_DRY=1
	epytest
}
