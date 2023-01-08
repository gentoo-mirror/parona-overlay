# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="DDUMONT"
inherit perl-module

DESCRIPTION="Test framework for Config::Model"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/File-Copy-Recursive
	>=dev-perl/Log-Log4perl-1.11
	dev-perl/Path-Tiny
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-perl/Module-Build
	test? (
		  dev-perl/Test-Differences
		  dev-perl/Test-Exception
		  dev-perl/Test-File-Contents
		  dev-perl/Test-Log-Log4perl
		  dev-perl/Test-Memory-Cycle
		  dev-perl/Test-Perl-Critic
		  dev-perl/Test-Warn
	)
"
