# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="PERLANCAR"
inherit perl-module

DESCRIPTION="Base class for color theme modules with static list of items"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/Color-RGB-Util
"
DEPEND="
	${RDEPEND}
	test? (
		dev-perl/Test-Exception
	)
"
