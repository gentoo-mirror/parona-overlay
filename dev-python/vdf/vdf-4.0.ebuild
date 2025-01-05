# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1

DESCRIPTION="A module for (de)serialization to and from VDF, Valve's key-value text format"
HOMEPAGE="
	https://github.com/solsticegamestudios/vdf/
"
SRC_URI="
	https://github.com/solsticegamestudios/vdf/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	!<dev-python/steam-1.4.4-r2
"

distutils_enable_tests pytest
