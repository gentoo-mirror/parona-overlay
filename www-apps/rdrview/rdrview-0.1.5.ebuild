# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Firefox Reader View as a command line tool"
HOMEPAGE="https://github.com/eafer/rdrview"
SRC_URI="https://github.com/eafer/rdrview/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
#RESTRICT="!test? ( test )"
RESTRICT="test" # broken tests

RDEPEND="
	dev-libs/libxml2:=
	net-misc/curl
	sys-libs/libseccomp
	www-client/lynx
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		app-text/htmltidy
		www-client/links
	)
"

src_prepare() {
	default

	sed -i -e '/require_tool valgrind/d' tests/check || die
}

src_configure() {
	append-cppflags -DNDEBUG
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_test() {
	pushd tests > /dev/null || die
	./check || die
	popd > /dev/null || die
}

src_install() {
	emake DESTDIR="${ED}" PREFIX="/usr" install
}
