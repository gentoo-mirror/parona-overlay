# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="BLUEFEET"
inherit perl-module

DESCRIPTION="A complete GitLab API v4 client."

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-perl/Const-Fast-0.014
	>=dev-perl/HTTP-Tiny-Multipart-0.05
	>=dev-perl/IO-Prompter-0.004014
	>=dev-perl/JSON-MaybeXS-1.003007
	>=dev-perl/Log-Any-1.703
	>=dev-perl/Log-Any-Adapter-Screen-0.13
	>=dev-perl/Moo-2.003000
	>=dev-perl/Path-Tiny-0.079
	>=dev-perl/Try-Tiny-0.28
	>=dev-perl/Type-Tiny-1.002001
	>=dev-perl/URI-1.62
	>=dev-perl/namespace-clean-0.27
	>=dev-perl/strictures-2.0.3
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-perl/Module-Build-Tiny-0.035
	test? (
		>=dev-perl/Log-Any-Adapter-TAP-0.003003
		>=virtual/perl-MIME-Base64-3.15
		>=virtual/perl-Test2-Suite-0.0.94
	)
"
