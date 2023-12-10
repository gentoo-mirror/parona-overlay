# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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
	sed -i -e 's:gzip -c -9 $(MANDIR)/$$prog$(man1ext) > $(DESTDIR)$(man1dir)/$$prog$(man1ext).gz:$(INSTALL_PROGRAM) $(INSTALL_FLAGS) $(MANDIR)/$$prog$(man1ext) $(DESTDIR)$(man1dir)/$$prog$(man1ext):' src/Makefile || die
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" libdir="${EPREFIX}/usr/$(get_libdir)" install
	einstalldocs
}
