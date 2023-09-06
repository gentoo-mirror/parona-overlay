# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Intel's monospaced font family with clarity and legibility in mind."
HOMEPAGE="https://github.com/intel/intel-one-mono"
SRC_URI="
	https://github.com/intel/intel-one-mono/releases/download/V${PV}/ttf.zip -> ${PN}-ttf-${PV}.zip
	https://github.com/intel/intel-one-mono/releases/download/V${PV}/otf.zip -> ${PN}-otf-${PV}.zip
"
S=${WORKDIR}

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

BDEPEND="app-arch/unzip"

src_install() {
	for suffix in {ttf,otf}; do
		FONT_S=${S}/${suffix} FONT_SUFFIX=${suffix} font_src_install
	done
}
