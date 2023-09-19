# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="PERLANCAR"
inherit perl-module

DESCRIPTION="Pretty-print data structure as JSON"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/JSON-Color
	dev-perl/JSON-MaybeXS
	dev-perl/String-LineNumber
"
DEPEND="${RDEPEND}"
