# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Humane command line arguments parser."
HOMEPAGE="
	https://github.com/jazzband/docopt-ng/
	https://pypi.org/project/docopt-ng/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# https://github.com/jazzband/docopt-ng/issues/22
# https://github.com/jazzband/docopt-ng/issues/48
# https://github.com/jazzband/docopt-ng/issues/54
RDEPEND="
	!dev-python/docopt
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
