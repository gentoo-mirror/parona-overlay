# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="GOG Downloading module for Heroic Games Launcher"
HOMEPAGE="https://github.com/Heroic-Games-Launcher/heroic-gogdl"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Heroic-Games-Launcher/heroic-gogdl"
else
	SRC_URI="
		https://github.com/Heroic-Games-Launcher/heroic-gogdl/archive/refs/tags/v${PV}.tar.gz
			-> ${P}.gh.tar.gz
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
"
