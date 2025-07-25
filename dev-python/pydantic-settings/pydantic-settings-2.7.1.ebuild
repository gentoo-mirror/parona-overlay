# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

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
"
BDEPEND="
	test? (
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
	# typing-extensions regression
	# https://github.com/pydantic/pydantic-settings/issues/591
	"tests/test_source_cli.py::test_cli_metavar_format_type_alias_312"
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
