# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="Simple GUI that displays the protocols implemented by a Wayland compositor."
HOMEPAGE="https://gitlab.freedesktop.org/serebit/waycheck/"
SRC_URI="
	https://gitlab.freedesktop.org/serebit/waycheck/-/archive/v${PV}/waycheck-v${PV}.tar.bz2
"
S="${WORKDIR}/waycheck-v${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-qt/qtbase-6.5:6[gui,widgets]
	>=dev-qt/qtwayland-6.5:6
	dev-libs/wayland
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"
