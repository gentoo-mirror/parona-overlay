# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="A self-contained cryptographic library for Python"
HOMEPAGE="
	https://www.pycryptodome.org/
	https://github.com/Legrandin/pycryptodome/
	https://pypi.org/project/pycryptodome/
"
SRC_URI="
	https://github.com/Legrandin/pycryptodome/archive/v${PV}.tar.gz
		-> pycryptodome-${PV}.gh.tar.gz
"
S="${WORKDIR}/pycryptodome-${PV}"

LICENSE="BSD-2 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/gmp:=
	>=dev-libs/libtomcrypt-1.18.2-r1:=
"
BDEPEND="
	$(python_gen_cond_dep 'dev-python/cffi[${PYTHON_USEDEP}]' 'python*')
"
RDEPEND="
	${DEPEND}
	${BDEPEND}
"

PATCHES=(
	"${FILESDIR}/pycryptodome-3.10.1-system-libtomcrypt.patch"
#	"${FILESDIR}/pycryptodome-3.19.0-fix-verbosity-in-tests.patch"
)

python_prepare_all() {
	# make sure we're unbundling it correctly
	rm -r src/libtom || die
	touch .separate_namespace || die
	distutils-r1_python_prepare_all
}

python_test() {
	local -x PYTHONPATH=${S}/test_vectors:${PYTHONPATH}
	"${EPYTHON}" - <<-EOF || die
		import sys
		from Cryptodome import SelfTest
		SelfTest.run(verbosity=2, stream=sys.stdout)
	EOF

	# TODO: run cmake tests from src/test?
}
