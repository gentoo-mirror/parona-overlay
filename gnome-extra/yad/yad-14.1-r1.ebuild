# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils xdg

DESCRIPTION="Display GTK+ dialog boxes from command line or shell scripts"
HOMEPAGE="https://github.com/v1cont/yad"
SRC_URI="https://github.com/v1cont/yad/releases/download/v${PV}/yad-${PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="sourceview spell tools webkit"

RDEPEND="
	dev-libs/glib:2
	>=x11-libs/gtk+-3.22.0:3
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	sourceview? ( x11-libs/gtksourceview:3.0= )
	spell? ( app-text/gspell:= )
	webkit? ( net-libs/webkit-gtk:4.1 )
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-util/intltool-0.40.0
	sys-devel/gettext
"

src_configure() {
	# Deprecated options? Needed or not 🤔
	econf \
		--enable-tray \
		$(use_enable sourceview) \
		$(use_enable spell) \
		$(use_enable tools) \
		$(use_enable tools icon-browser) \
		$(use_enable !tools standalone) \
		$(use_enable webkit html)
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
