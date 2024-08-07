# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.0.0
QTMIN=6.0.0
inherit ecm git-r3

DESCRIPTION="Plasma widget to show processes running in gamemode"
HOMEPAGE="https://invent.kde.org/sitter/plasma-gamemode"
EGIT_REPO_URI="https://invent.kde.org/sitter/plasma-gamemode"

LICENSE="BSD CC0-1.0 GPL-2 GPL-3 LGPL-3"
SLOT="0"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kdeclarative-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-plasma/libplasma-6.0.0:6
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_SIMULATION=NO # noop
	)
	cmake_src_configure
}
