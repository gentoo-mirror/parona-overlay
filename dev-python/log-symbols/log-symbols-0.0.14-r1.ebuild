# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Colored symbols for various log levels for Python"
HOMEPAGE="
	https://github.com/manrajgrover/py-log-symbols
	https://pypi.org/project/log-symbols/
"
#no tags
COMMIT="eb527ec951e3d02c828efdb56e9f78e364c109b2"
SRC_URI="https://github.com/manrajgrover/py-log-symbols/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/py-${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]"
BDEPEND="test? ( ${RDEPEND} )"

distutils_enable_tests unittest
