# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Spinners for terminals"
HOMEPAGE="https://pypi.org/project/spinners/"
# no tags
COMMIT="a73d561aa58b12afc3aa4ee80143dca87656688d"
SRC_URI="https://github.com/manrajgrover/py-spinners/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/py-${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest

src_prepare() {
	eapply_user

	# Deprecated alias
	sed -i -e 's/assertEquals/assertEqual/' tests/test_spinners.py || die
}
