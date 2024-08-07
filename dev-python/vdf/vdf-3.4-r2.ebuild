# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1

DESCRIPTION="A module for (de)serialization to and from VDF, Valve's key-value text format"
HOMEPAGE="
	https://github.com/ValvePython/vdf/
	https://pypi.org/project/vdf/
"
SRC_URI="
	https://github.com/ValvePython/vdf/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}"/vdf-3.4-deserialization-support.patch
)

RDEPEND="
	!<dev-python/steam-1.4.4-r2
"

distutils_enable_tests pytest
