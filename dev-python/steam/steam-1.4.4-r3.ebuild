# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1

DESCRIPTION="Python package for interacting with Steam"
HOMEPAGE="
	https://pypi.org/project/steam/
	https://github.com/ValvePython/steam
"
SRC_URI="
	https://github.com/ValvePython/steam/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}"/steam-1.4.4-appinfo.vdf-v29-support.patch
	"${FILESDIR}"/steam-1.4.4-fix-tests-with-urllib3-2.patch
)

RDEPEND="
	>=dev-python/cachetools-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pycryptodomex-3.7.0[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/vdf-3.4-r2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/vcrpy[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# Don't care about the client, it require gevent which is problematic
	"tests/test_core_cm.py"
)

distutils_enable_tests pytest
