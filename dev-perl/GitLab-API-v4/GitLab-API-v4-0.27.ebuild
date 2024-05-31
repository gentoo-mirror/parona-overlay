# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="BLUEFEET"
inherit perl-module

DESCRIPTION="A complete GitLab API v4 client."

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/Const-Fast
	dev-perl/HTTP-Tiny-Multipart
	dev-perl/IO-Prompter
	dev-perl/JSON-MaybeXS
	dev-perl/Log-Any
	dev-perl/Log-Any-Adapter-Screen
	dev-perl/Moo
	dev-perl/Path-Tiny
	dev-perl/Try-Tiny
	dev-perl/Type-Tiny
	dev-perl/URI
	dev-perl/namespace-clean
	dev-perl/strictures
"
DEPEND="
	${RDEPEND}
	perl-core/Test2-Suite
"
BDEPEND="dev-perl/Module-Build-Tiny"
