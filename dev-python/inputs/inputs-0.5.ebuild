# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Cross-platform Python support for keyboards, mice and gamepads."
HOMEPAGE="
	https://pypi.org/project/inputs/
	https://github.com/zeth/inputs
"
SRC_URI="
	https://github.com/zeth/inputs/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
