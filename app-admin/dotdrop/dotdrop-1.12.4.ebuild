# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Save your dotfiles once, deploy them everywhere"
HOMEPAGE="
	https://deadc0de.re/dotdrop/
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
	dev-python/toml[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/halo[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest

src_prepare() {
	eapply_user
	sed -i 's/check_version: true/check_version: false/' tests-ng/env.sh || die
}

python_test() {
	eunittest
	# PITA
	#${EPYTHON} tests-ng/tests-launcher.py || die
}
