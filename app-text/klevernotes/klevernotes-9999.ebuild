# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN="6.4"
QTMIN="6.5"
inherit ecm kde.org

DESCRIPTION="A note-taking and management application using markdown."
HOMEPAGE="
	https://apps.kde.org/klevernotes/
	https://invent.kde.org/office/klevernotes/
"

LICENSE="BSD CC-BY-SA-4.0 CC0-1.0 FSFAP GPL-2+ GPL-3 GPL-3+ LGPL-2 LGPL-2+ LGPL-2.1 LGPL-2.1 LGPL-3 MIT"
SLOT="0"
KEYWORDS=""

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=dev-qt/qtwebengine-${QTMIN}:6[qml]
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kcolorscheme-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
"
RDEPEND="${DEPEND}"
