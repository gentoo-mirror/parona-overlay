# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="CLKAO"
inherit perl-module

DESCRIPTION="Test log4perl"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/Log-Log4perl
	dev-perl/Test-Exception
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-perl/Module-Build
"
