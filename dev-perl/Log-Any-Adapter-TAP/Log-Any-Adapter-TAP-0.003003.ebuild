# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="NERDVANA"
inherit perl-module

DESCRIPTION="Logger suitable for use with TAP test files"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-perl/Log-Any
	dev-perl/Try-Tiny
"
DEPEND="${RDEPEND}"
