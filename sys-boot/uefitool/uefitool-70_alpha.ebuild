# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PV="A$(ver_cut 1)"

DESCRIPTION="UEFI firmware image viewer and editor"
HOMEPAGE="https://github.com/LongSoft/UEFITool"
SRC_URI="
	https://github.com/LongSoft/UEFITool/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/UEFITool-${MY_PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[widgets]
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
