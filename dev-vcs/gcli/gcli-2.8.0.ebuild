# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Portable CLI tool for interacting with Git(Hub|Lab|Tea) from the command line."
HOMEPAGE="https://herrhotzenplotz.de/gcli/"
SRC_URI="https://herrhotzenplotz.de/gcli/releases/gcli-${PV}/gcli-${PV}.tar.xz"

LICENSE="BSD-2 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+libedit lowdown test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/openssl:=
	net-misc/curl[openssl]
	x11-misc/xdg-utils
	libedit? (
		dev-libs/libedit
	)
	!libedit? (
		sys-libs/readline:=
	)
	lowdown? (
		app-text/lowdown:=
	)
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
	# use ccache via portage
	local -x CCACHE=" " # whitespace required...

	local myconf=(
		--prefix="${EPREFIX}/usr"
		$(use_enable libedit)
		$(use_enable !libedit libreadline)
		$(use_enable lowdown liblowdown)
	)

	./configure ${myconf[@]} || die
}
