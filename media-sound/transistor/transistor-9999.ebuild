# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN="6.0"
QTMIN="6.5"
inherit ecm git-r3

DESCRIPTION="Internet radio player"
HOMEPAGE="https://invent.kde.org/saurov/transistor"
EGIT_REPO_URI="https://invent.kde.org/saurov/transistor.git"

LICENSE="BSD BSD-2 CC0-1.0 FSFAP GPL-2+"
SLOT="0"

DEPEND="
	dev-libs/kirigami-addons:6
	>=dev-qt/qtbase-${QTMIN}:6[gui,sql]
	>=dev-qt/qtdeclarative-${QTMIN}:6[sql,svg]
	>=dev-qt/qtmultimedia-${QTMIN}:6[qml]
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/kcolorscheme-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
"
RDEPEND="${DEPEND}"
