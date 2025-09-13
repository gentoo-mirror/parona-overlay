# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font unpacker

DESCRIPTION="Lora fonts — serif family for text. Variable Open Source Font"
HOMEPAGE="https://github.com/cyrealtype/Lora-Cyrillic"
SRC_URI="
	https://github.com/cyrealtype/Lora-Cyrillic/releases/download/v${PV}/Lora-v${PV}.zip
"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="otf"

BDEPEND="app-arch/unzip"

src_install() {
	FONT_S="${S}/fonts/ttf" FONT_SUFFIX="ttf" font_src_install
	use otf && FONT_S="${S}/fonts/otf" FONT_SUFFIX="otf" font_src_install
}
