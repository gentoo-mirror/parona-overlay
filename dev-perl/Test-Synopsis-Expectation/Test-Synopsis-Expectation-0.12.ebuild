# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="MOZNION"
inherit perl-module

DESCRIPTION="Test that SYNOPSIS code produces expected results"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-perl/Module-Build"
