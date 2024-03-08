# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Scripts and hooks that I use on my machines"
HOMEPAGE="https://gitlab.com/Parona/parona-scripts"
EGIT_REPO_URI="https://gitlab.com/Parona/parona-scripts.git"

LICENSE="GPL-3"
SLOT="0"

IUSE="efibootmgr perl"

RESTRICT="test" # no tests

RDEPEND="
	app-text/ansifilter
	net-misc/curl
	efibootmgr? (
		app-portage/eix
		sys-kernel/installkernel[-grub]
	)
	perl? (
		dev-perl/GitLab-API-v4
		dev-lang/perl
		dev-perl/DateTime-Format-ISO8601
		dev-perl/Number-Bytes-Human
	)
"

src_install() {
	emake DESTDIR="${D}" install

	if use efibootmgr; then
		emake DESTDIR="${D}" efibootmgr
	fi

	if use perl; then
		emake DESTDIR="${D}" perl
	fi
}
