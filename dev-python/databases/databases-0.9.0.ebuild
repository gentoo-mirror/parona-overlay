# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Async database support for Python."
HOMEPAGE="
	https://github.com/encode/databases
	https://pypi.org/project/databases/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/aiosqlite[${PYTHON_USEDEP}]
		dev-python/asyncpg[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
# TODO: asyncmy (asyncio incompatiblity)?
# aiopg redundant due to psycopg3
# aiomysql requires and old sqlalchemy https://github.com/aio-libs/aiomysql/issues/818
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# aiopg unpackaged
	tests/test_connection_options.py
)

python_test() {
	local -x TEST_DATABASE_URLS="sqlite:///testsuite, sqlite+aiosqlite:///testsuite"
	epytest
}

pkg_postinst() {
	optfeature_header "Install for database support:"
	optfeature "SQLite" dev-python/aiosqlite
}
