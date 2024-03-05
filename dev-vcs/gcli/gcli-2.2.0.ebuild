# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Portable CLI tool for interacting with Git(Hub|Lab|Tea) from the command line."
HOMEPAGE="https://herrhotzenplotz.de/gcli/"
SRC_URI="https://herrhotzenplotz.de/gcli/releases/gcli-${PV}/gcli-${PV}.tar.xz"

LICENSE="BSD-2 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	net-misc/curl
"
DEPEND="
	${RDEPEND}
	test? (
		dev-libs/atf
		dev-util/kyua
	)
"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	econf --disable-shared
}
