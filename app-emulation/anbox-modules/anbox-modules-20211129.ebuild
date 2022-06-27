# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

DESCRIPTION="Anbox kernel modules (ashmem and binder) fork"
HOMEPAGE="https://github.com/choff/anbox-modules"

if [[ "${PV}" == "99999999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/choff/anbox-modules"
else
	COMMIT="8148a162755bf5500a07cf41a65a02c8f3eb0af9"
	SRC_URI="https://github.com/choff/anbox-modules/archive/${COMMIT}.tar.gz -> ${PN}-choff_fork-${PV}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

BUILD_TARGETS="clean all"
MODULE_NAMES="ashmem_linux(updates:${S}/ashmem) binder_linux(updates:${S}/binder)"

PATCHES=("${FILESDIR}/patches_for_5.18_kernel.patch")

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL_SRC=${KERNEL_DIR}"
}
