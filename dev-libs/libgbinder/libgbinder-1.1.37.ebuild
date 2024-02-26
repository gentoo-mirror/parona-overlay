# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GLib-style interface to binder"
HOMEPAGE="https://github.com/mer-hybris/libgbinder"
SRC_URI="https://github.com/mer-hybris/libgbinder/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/libglibutil
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_compile() {
	emake KEEP_SYMBOLS=1 LIBDIR="/usr/$(get_libdir)"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install install-dev
}
