# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Colored symbols for various log levels for Python"
HOMEPAGE="
	https://github.com/manrajgrover/py-log-symbols
	https://pypi.org/project/log-symbols/
"
SRC_URI="$(pypi_sdist_url "${PN/-/_}")"
S="${WORKDIR}/${MY_P}"

KEYWORDS="~amd64"

LICENSE="MIT"
SLOT="0"

RESTRICT="test"

RDEPEND=">=dev-python/colorama-0.3.9"
#BDEPEND="test? ( ${RDEPEND} )"

distutils_enable_tests unittest
