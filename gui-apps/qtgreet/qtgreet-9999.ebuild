# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson xdg

DESCRIPTION="Qt based greeter for greetd"
HOMEPAGE="https://marcusbritanicus.gitlab.io/QtGreet/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/marcusbritanicus/QtGreet"
else
	SRC_URI="
		https://gitlab.com/marcusbritanicus/QtGreet/-/archive/v${PV}/QtGreet-v${PV}.tar.bz2
	"
	S="${WORKDIR}/QtGreet-v${PV}"

	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="+greetwl qt6"

# mpv automagic
RDEPEND="
	media-video/mpv:=
	greetwl? (
		dev-libs/wayland
		gui-libs/wlroots:0.18
		x11-libs/libxkbcommon
	)
	qt6? (
		dev-qt/qtbase:6[gui,dbus,opengl,widgets]
		gui-libs/dfl-applications[qt6]
		gui-libs/dfl-ipc[qt6]
		gui-libs/dfl-login1[qt6]
		gui-libs/dfl-utils[qt6]
		>=gui-libs/wayqt-9999[qt6]
	)
	!qt6? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		gui-libs/dfl-applications[qt5]
		gui-libs/dfl-ipc[qt5]
		gui-libs/dfl-login1[qt5]
		gui-libs/dfl-utils[qt5]
		gui-libs/wayqt[qt5]
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default

	sed -i -e "s/version: '2.0.0'/version: '${PV}'/" meson.build || die
}

src_configure() {
	# violates ODR
	# https://gitlab.com/marcusbritanicus/QtGreet/-/merge_requests/10
	filter-lto

	local emesonargs=(
		$(meson_use greetwl build_greetwl)
		-Duse_qt_version=$(usex qt6 qt6 qt5)
		-Dusername=greetd
		-Dnodynpath=true
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	keepdir /var/lib/qtgreet
}
