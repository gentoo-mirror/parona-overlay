# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 multiprocessing shell-completion

DESCRIPTION="Save your dotfiles once, deploy them everywhere"
HOMEPAGE="
	https://deadc0de.re/dotdrop/
	https://github.com/deadc0de6/dotdrop
	https://pypi.org/project/dotdrop/
"
SRC_URI="https://github.com/deadc0de6/dotdrop/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/tomli-w[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/tomli[${PYTHON_USEDEP}]' 3.10)
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
	app-editors/vim-core
"

distutils_enable_tests pytest

src_prepare() {
	eapply_user

	# Lets remove the eye candy spinner, GITHUB_WORKFLOW means it wont be used eitherway.
	sed -i '/from halo/d' tests-ng/tests_launcher.py || die

	# directories getting removed on failure doesnt help with debugging.
	sed -i '/clear_on_exit/d' tests-ng/*.sh || die

	## tests that are too much effort to fix
	# long file paths are not expected.
	rm tests-ng/import-to-no-profile.sh || die
}

src_install() {
	distutils-r1_src_install

	doman manpage/dotdrop.1

	newbashcomp completion/dotdrop-completion.bash dotdrop
	dofishcomp completion/dotdrop.fish
	newzshcomp completion/_dotdrop-completion.zsh _dotdrop-completion
}

python_test() {
	epytest -n "$(makeopts_jobs)" --dist=worksteal

	local -x GITHUB_WORKFLOW=1 # no need for a spinner, would make logs harder to read
	local -x DOTDROP_WORKDIR="${T}/dotdrop_workdir/" # hardcoded tmp dir outside sandbox otherwise
	${EPYTHON} tests-ng/tests_launcher.py "$(makeopts_jobs)" || die
}
