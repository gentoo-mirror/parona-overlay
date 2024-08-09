# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
ECM_TEST="false"
KDE_ORG_CATEGORY="system"
KFMIN=5.98.0
QTMIN=5.15.0
inherit ecm gear.kde.org

DESCRIPTION="Manage files as administrator using the admin:// KIO protocol."
HOMEPAGE="https://invent.kde.org/system/kio-admin"

LICENSE="BSD CC0-1.0 FSFAP GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	sys-auth/polkit-qt[qt6]
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DQT_MAJOR_VERSION=6
	)
	cmake_src_configure
}
