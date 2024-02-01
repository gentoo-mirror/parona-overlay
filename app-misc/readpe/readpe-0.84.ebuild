# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion toolchain-funcs

DESCRIPTION="The PE file analysis toolkit"
HOMEPAGE="https://github.com/mentebinaria/readpe"
SRC_URI="https://github.com/mentebinaria/readpe/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+-with-openssl-exception" # gpl-2+ or gpl-2?
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/openssl:=
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# Let prefix be overriden
	sed -i -e 's/prefix =/prefix :=/' src/Makefile lib/libpe/Makefile || die
	# Don't compress man pages by default
	sed -i \
		-e 's:gzip -c -9 \($(MANDIR)/$$prog$(man1ext)\) > \($(DESTDIR)$(man1dir)/$$prog$(man1ext)\).gz:$(INSTALL_PROGRAM) $(INSTALL_FLAGS) \1 \2:' \
		src/Makefile || die

	# Abuses CFLAGS (with unnecessary flag)
	sed -i -e '/override CFLAGS/,/^$/ { s/-c// }' lib/libpe/Makefile || die

	# Respect CFLAGS
	sed -i \
		-e '/^\(ofs2rva\|libpe\|$(PLUGINS)\):/,/^$/ { s/$(LDFLAGS)/$(CFLAGS) $(LDFLAGS)/ }' \
		src/Makefile lib/libpe/Makefile src/plugins/Makefile || die

	sed -i \
		-e '/function test_binary_output_against_expected_output/,/^}$/ { s/\(^\s*\)#/\1/ }' \
		-e 's/head -n 5 tmp.diff/diff -u "${expected_output}" "${reported_output}"/' \
		tests/run.sh || die
}

src_configure() {
	tc-export CC
}

src_test() {
	export LD_LIBRARY_PATH="${S}/lib/libpe"
	cp "${S}"/lib/libpe/libpe.so{,.1} || die

	# pepack segfaults without this lol
	cp "${S}"{/src,}/userdb.txt || die

	# pe64: "coming soon..."

	./tests/run.sh pe32 tests/samples/helloworld.exe
	pe32_ret=$?

	if [[ ${pe32_ret} == 0 ]]; then
		einfo "All tests s!cceeded"
	else
		[[ ${pe32_ret} != 0 ]] && ewarn "pe32 failed: ${pe32_ret}"
		eerror "Some tests failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" libdir="${EPREFIX}/usr/$(get_libdir)" install
	einstalldocs

	dobashcomp completion/bash/readpe
	bashcomp_alias readpe pedis pehash peldd pepack peres pescan pesec pestr
	dozshcomp completion/zsh/_readpe
}
