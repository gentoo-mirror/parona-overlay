# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

PGPROTO_COMMIT="1c3cad14d53c8f3088106f4eab8f612b7293569b"

DESCRIPTION="A fast PostgreSQL Database Client Library for Python/asyncio."
HOMEPAGE="
	https://github.com/MagicStack/asyncpg/
	https://pypi.org/project/asyncpg/
"
SRC_URI="
	https://github.com/MagicStack/asyncpg/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
	https://github.com/MagicStack/py-pgproto/archive/${PGPROTO_COMMIT}.tar.gz
		-> py-pgproto-${PGPROTO_COMMIT}.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/postgresql
"
BDEPEND="
	<dev-python/cython-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/cython-0.29.24[${PYTHON_USEDEP}]
	test? (
		dev-python/gssapi[${PYTHON_USEDEP}]
		dev-python/k5test[${PYTHON_USEDEP}]
		dev-python/mypy[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}"/asyncpg-0.29.0-python3.13.patch
	"${FILESDIR}"/asyncpg-0.29.0-cython3.patch
	"${FILESDIR}"/asyncpg-0.29.0-relax-ssl-for-python3.13.patch
)

distutils_enable_tests pytest

src_prepare() {
	default

	mv -T "${WORKDIR}"/py-pgproto-${PGPROTO_COMMIT} "${S}"/asyncpg/pgproto || die
}

python_test() {
	rm -rf asyncpg || die
	local -x ASYNCPG_VERSION="${PV}"
	epytest
}
