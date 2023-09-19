# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="TOBYINK"
inherit perl-module

DESCRIPTION="create a fake infix operator"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="test? ( dev-perl/Test-Fatal )"
