# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )
inherit distutils-r1

MY_PN="gbinder-python"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python bindings for libgbinder"
HOMEPAGE="
	https://github.com/erfanoabdi/gbinder-python
"
SRC_URI="
	https://github.com/erfanoabdi/gbinder-python/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # uses Itest test suite

DEPEND="
	dev-libs/libgbinder
	dev-libs/libglibutil
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
"

python_configure_all() {
	DISTUTILS_ARGS=( --cython )
}
