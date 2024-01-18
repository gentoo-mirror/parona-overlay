# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Scripts and hooks that I use on my machines"
HOMEPAGE="https://gitlab.com/Parona/parona-scripts"
EGIT_REPO_URI="https://gitlab.com/Parona/parona-scripts.git"

LICENSE="GPL-3"
SLOT="0"

IUSE="efibootmgr"

RESTRICT="test" # no tests

RDEPEND="
	sys-kernel/installkernel
	efibootmgr? (
		sys-kernel/installkernel[-grub]
	)
"

src_install() {
	if use efibootmgr; then
		exeinto /etc/kernel/postinst.d
		doexe installkernel-hooks/postinst.d/92-efibootmgr.install
	fi
}
