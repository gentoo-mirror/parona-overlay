# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="PERLANCAR"
inherit perl-module

DESCRIPTION="Send logs to screen, with colors and some other features"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/Log-Any
"
DEPEND="${RDEPEND}"
