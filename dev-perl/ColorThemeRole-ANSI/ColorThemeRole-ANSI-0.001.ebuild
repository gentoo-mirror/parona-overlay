# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="PERLANCAR"
inherit perl-module

DESCRIPTION="Roles for using ColorTheme::* with ANSI codes"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/ColorThemeUtil-ANSI
	dev-perl/Role-Tiny
"
DEPEND="${RDEPEND}"
