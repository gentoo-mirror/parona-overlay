# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="FastAPI framework, high performance, easy to learn, ready for production"
HOMEPAGE="
	https://fastapi.tiangolo.com/
	https://pypi.org/project/fastapi/
	https://github.com/fastapi/fastapi
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/anyio[${PYTHON_USEDEP}]
		dev-python/databases[${PYTHON_USEDEP}]
		dev-python/dirty-equals[${PYTHON_USEDEP}]
		dev-python/email-validator[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/orjson[${PYTHON_USEDEP}]
		dev-python/passlib[${PYTHON_USEDEP}]
		dev-python/pydantic-settings[${PYTHON_USEDEP}]
		dev-python/pyjwt[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
		dev-python/ujson[${PYTHON_USEDEP}]

	)
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Depends on coverage
	"tests/test_fastapi_cli.py::test_fastapi_cli"
)

pkg_postinst() {
	optfeature "commandline interface" dev-python/fastapi-cli
	optfeature "test client" dev-python/httpx
	optfeature "templates" dev-python/jinja
	optfeature "forms and file uploads" dev-python/python-multipart
	optfeature "validate emails" dev-python/email-validator
	optfeature "uvicorn with uvloop" dev-python/uvicorn
	optfeature_header "Alternative JSON responses"
	optfeature "ORJSONResponse" dev-python/orjson
	optfeature "UJSONResponse" dev-python/ujson
}
