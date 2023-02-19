# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION="0.48"

inherit meson vala

DESCRIPTION="Code Intelligence for Vala & Genie"
HOMEPAGE="https://github.com/vala-lang/vala-language-server"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vala-lang/vala-language-server"
else
	SRC_URI="https://github.com/vala-lang/vala-language-server/releases/download/${PV}/vala-language-server-${PV}.tar.xz"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2.1"
SLOT="0"

IUSE="debug gnome +man"
# Tests nonexistant
RESTRICT="test"

RDEPEND="
	dev-libs/glib
	dev-libs/jsonrpc-glib[vala]
	dev-libs/libgee
	dev-libs/json-glib
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
	gnome? ( dev-util/gnome-builder )
	man? ( >=app-text/scdoc-1.9.2 )
"

pkg_setup() {
	vala_setup
}

src_prepare() {
	sed -i '/version_file/,/^$/ { /command/d; /output/ { s/,/)/ } }' meson.build || die
	default
}

src_configure() {
	local emesonargs=(
		$(meson_use debug debug_mem)
		$(meson_use gnome plugins)
		$(meson_feature man man_pages)
		#$(meson_use test tests)
		-Dactive_parameter=false
		-Dbuilder_abi=auto
	)
	meson_src_configure
}
