# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Anbox kernel modules (ashmem and binder) fork"
HOMEPAGE="https://github.com/choff/anbox-modules"

if [[ "${PV}" == "99999999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/choff/anbox-modules"
else
	COMMIT="084d19950a39673e42954632f4ac44870055b4c6"
	SRC_URI="https://github.com/choff/anbox-modules/archive/${COMMIT}.tar.gz -> ${PN}-choff_fork-${PV}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

src_compile() {
	local modlist=( ashmem_linux=updates:ashmem binder_linux=updates:binder )
	local modargs=( KERNEL_SRC="${KV_OUT_DIR}" )

	linux-mod-r1_src_compile
}
