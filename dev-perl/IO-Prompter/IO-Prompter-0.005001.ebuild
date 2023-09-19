# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="DCONWAY"
inherit perl-module

DESCRIPTION="Prompt for input, read it, clean it, return it."

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/Contextual-Return
	dev-perl/match-simple
"
DEPEND="${RDEPEND}"
