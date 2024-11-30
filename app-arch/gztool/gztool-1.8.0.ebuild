# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="GZIP files indexer, compressor and data retriever."
HOMEPAGE="https://github.com/circulosmeos/gztool/"
SRC_URI="https://github.com/circulosmeos/gztool/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sys-libs/zlib
"
DEPEND="${RDEPEND}"

src_prepare() {
	eapply_user
	eautoreconf
}
