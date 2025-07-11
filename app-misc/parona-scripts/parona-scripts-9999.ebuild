# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 optfeature

DESCRIPTION="Scripts and hooks that I use on my machines"
HOMEPAGE="https://gitlab.com/Parona/parona-scripts"
EGIT_REPO_URI="https://gitlab.com/Parona/parona-scripts.git"

LICENSE="GPL-3"
SLOT="0"

IUSE="efibootmgr perl portage-hooks"

RESTRICT="test" # no tests

RDEPEND="
	app-admin/eclean-kernel
	app-misc/jq
	app-portage/gentoolkit
	app-portage/portage-utils
	app-portage/smart-live-rebuild
	app-text/ansifilter
	net-misc/curl
	sys-apps/file
	sys-apps/grep
	sys-apps/pkgcore
	sys-apps/portage
	sys-apps/util-linux
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
	portage-hooks? (
		app-portage/eix
		sys-apps/pkgcore
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

	if use portage-hooks; then
		emake DESTDIR="${D}" portage_hooks
	fi
}

pkg_postinst() {
	if use portage-hooks; then
		optfeature "faster repository metadata generation" sys-apps/pkgcraft-tools
	fi
}
