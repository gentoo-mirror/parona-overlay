# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY="utilities"
ECM_HANDBOOK="true"
KFMIN=6.0
QTMIN=6.6
inherit ecm kde.org

DESCRIPTION="Organize your tasks"
HOMEPAGE="https://apps.kde.org/tasks/"

LICENSE="BSD-2 BSD CC0-1.0 GPL-3+ LGPL-2+ LGPL-2.1+"
SLOT="0"

COMMON_DEPEND="
	>=dev-libs/kirigami-addons-1.0:6
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6[svg,widgets]
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kitemmodels-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"
