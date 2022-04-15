# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vala xdg gnome2-utils meson

DESCRIPTION="All your games in one place"
HOMEPAGE="https://tkashkin.github.io/projects/gamehub/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tkashkin/GameHub"
	EGIT_BRANCH="dev"
	SLOT="0"
else
	if [[ "${PV}" =~ "_pre" ]]; then
		SLOT="0/dev"
		RELEASE_TYPE="dev"
	else
		SLOT="0/stable"
		RELEASE_TYPE="master"
	fi

	MY_PV="${PV/_pre/-}"
	MY_PV="${MY_PV/_p/-}"

	SRC_URI="https://github.com/tkashkin/GameHub/archive/refs/tags/${MY_PV}-${RELEASE_TYPE}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/GameHub-${MY_PV}-${RELEASE_TYPE}"

	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"

IUSE="+overlayfs"

DEPEND="
	x11-libs/gtk+:3
	dev-libs/json-glib
	dev-libs/libgee
	dev-db/sqlite:3
	dev-libs/libxml2
	dev-libs/glib
	sys-libs/zlib
	net-libs/libsoup
	net-libs/webkit-gtk:4
	dev-libs/libmanette
	x11-libs/libX11
	x11-libs/libXtst
	overlayfs? (
		sys-auth/polkit[gtk]
	)
"
#	unity? (
#		dev-libs/libunity
#	)
#"
RDEPEND="${DEPEND}"
BDEPEND="
	$(vala_depend)
"

src_prepare () {
	eapply_user
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dos=linux
		-Ddistro=generic
		-Dpackage=generic
		$(meson_use overlayfs feature_overlayfs)
#		$(meson_use unity use_libunity)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
