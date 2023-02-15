# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Firefox Reader View as a command line tool"
HOMEPAGE="https://github.com/eafer/rdrview"
SRC_URI="https://github.com/eafer/rdrview/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/libxml2
	net-misc/curl
	sys-libs/libseccomp
"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${ED}" PREFIX="/usr" install
}
