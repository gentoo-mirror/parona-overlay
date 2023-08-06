# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="GFUJI"
inherit perl-module

DESCRIPTION="Make your object constructors blow up on unknown attributes"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-perl/Mouse-0.62
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-perl/Module-Install
"
