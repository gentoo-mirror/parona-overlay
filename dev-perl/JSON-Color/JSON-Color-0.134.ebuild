# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="PERLANCAR"
inherit perl-module

DESCRIPTION="Encode to colored JSON"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/Color-ANSI-Util
	dev-perl/ColorThemeBase-Static
	dev-perl/ColorThemeRole-ANSI
	dev-perl/ColorThemes-Standard
	dev-perl/Graphics-ColorNamesLite-WWW
	dev-perl/Module-Load-Util
	dev-perl/Role-Tiny
	dev-perl/Term-ANSIColor
"
DEPEND="${RDEPEND}"
