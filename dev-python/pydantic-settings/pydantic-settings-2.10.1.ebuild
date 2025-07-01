# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Settings management using pydantic"
HOMEPAGE="
	https://pypi.org/project/pydantic-settings/
	https://github.com/pydantic/pydantic-settings
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pydantic-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-0.21.0[${PYTHON_USEDEP}]
	>=dev-python/typing-inspection-0.4.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-util/diff-cover-9.2.0[${PYTHON_USEDEP}]
		dev-python/boto3[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/pytest-examples[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-examples pytest-mock )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# TODO: requires azure package
	"tests/test_docs.py::test_docs_examples"
	# TODO: AssertionError: assert 'pydantic_settings-2.4.0.tar.gz' == 'default'
	"tests/test_settings.py::test_ignore_empty_with_dotenv_when_empty_uses_default"
	"tests/test_settings.py::test_ignore_empty_with_dotenv_when_not_empty_uses_value"
	# TODO: Failed: DID NOT RAISE <class 'UserWarning'>
	"tests/test_settings.py::test_protected_namespace_defaults"
)

EPYTEST_IGNORE=(
	# TODO: requires azure package
	"tests/test_source_azure_key_vault.py"
)

python_test() {
	# parsing --help output is width dependent
	local -x COLUMNS=80
	epytest
}

pkg_postinst() {
	optfeature "aws secret manager" dev-python/boto3
}
