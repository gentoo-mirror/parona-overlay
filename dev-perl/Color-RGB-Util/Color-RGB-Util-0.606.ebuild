# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="PERLANCAR"
inherit perl-module

DESCRIPTION="Utilities related to RGB colors"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	test? (
		dev-perl/Test-Exception
		dev-perl/Test-RandomResult
	)
"
