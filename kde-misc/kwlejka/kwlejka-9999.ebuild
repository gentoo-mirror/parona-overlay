# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A text area for Plasma"
HOMEPAGE="https://codeberg.org/dcz/kwlejka"
EGIT_REPO_URI="https://codeberg.org/dcz/kwlejka.git"

LICENSE="GPL-2+"
SLOT="0"

RDEPEND="
	dev-qt/qtdeclarative:6
	kde-plasma/libplasma:6
	kde-frameworks/kirigami:6
	kde-frameworks/ksvg:6
"

src_install() {
	insinto /usr/share/plasma/plasmoids
	doins -r kwlejka
}
