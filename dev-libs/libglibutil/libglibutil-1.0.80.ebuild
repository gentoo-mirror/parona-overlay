# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Library of glib utilities"
HOMEPAGE="https://github.com/sailfishos/libglibutil"
SRC_URI="https://github.com/sailfishos/libglibutil/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/glib-2.32:2
"
RDEPEND="${DEPEND}"

src_compile() {
	emake KEEP_SYMBOLS=1 LIBDIR="/usr/$(get_libdir)"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install install-dev
}
