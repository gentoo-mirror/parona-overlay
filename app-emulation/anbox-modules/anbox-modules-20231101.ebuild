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
	COMMIT="205c8037e61d4546d8c86c1f789cfaf18fa9bc24"
	SRC_URI="https://github.com/choff/anbox-modules/archive/${COMMIT}.tar.gz -> ${PN}-choff_fork-${PV}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

src_compile() {
	# ashmem isn't necessary and doesn't build against >6.3 kernels. Nobody appears to care
	local modlist=( binder_linux=updates:binder )
	local modargs=( KERNEL_SRC="${KV_OUT_DIR}" )

	linux-mod-r1_src_compile
}
