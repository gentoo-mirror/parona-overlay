# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="DDUMONT"
inherit perl-module

DESCRIPTION="A framework to validate, migrate and edit configuration files"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/Carp-Assert-More
	dev-perl/File-HomeDir
	>=dev-perl/Hash-Merge-0.12
	dev-perl/JSON
	dev-perl/List-MoreUtils
	>=dev-perl/Log-Log4perl-1.11
	dev-perl/Mouse
	dev-perl/MouseX-NativeTraits
	dev-perl/MouseX-StrictConstructor
	>=dev-perl/Parse-RecDescent-1.90.0
	>=dev-perl/Path-Tiny-0.070
	dev-perl/Pod-POM
	dev-perl/Regexp-Common
	dev-perl/Test-Synopsis-Expectation
	dev-perl/YAML-Tiny
	|| (
		dev-perl/Term-ReadLine-Gnu
		dev-perl/Term-ReadLine-Perl
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-perl/Module-Build
	test? (
		${RDEPEND}
		dev-perl/boolean
		dev-perl/Config-Model-Tester
		dev-perl/Test-Differences
		dev-perl/Test-Exception
		dev-perl/Test-File-Contents
		dev-perl/Test-Log-Log4perl
		dev-perl/Test-Memory-Cycle
		dev-perl/Test-Perl-Critic
		dev-perl/Test-Pod
		dev-perl/Test-Warn
	)
"

src_prepare() {
	eapply_user

	sed -E -i '/my \$build/,/^\);$/ { /(build_|configure_|)requires/,/\},$/ d }' Build.PL || die
}
