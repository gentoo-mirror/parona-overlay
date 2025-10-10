# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LAZARUS_WIDGET=qt6
inherit desktop lazarus xdg

DESCRIPTION="A simple opengl spinning cube in pascal"
HOMEPAGE="https://github.com/benjamimgois/pascube/"
SRC_URI="
	https://github.com/benjamimgois/pascube/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	media-libs/libglvnd
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

QA_FLAGS_IGNORED=".*"

src_compile() {
	elazbuild pascube.lpi
}

src_install() {
	exeinto /usr/libexec
	doexe pascube

	newbin - pascube <<-EOF
	#!/bin/sh
	export QT_QPA_PLATFORM=xcb
	exec /usr/libexec/pascube "$@"
	EOF

	domenu data/pascube.desktop
	for size in 128 256 512; do
		doicon -s ${size} data/icons/${size}x${size}/pascube.png
	done

	insinto /usr/share/pascube/
	doins data/skybox.png data/skybox1.png

	einstalldocs
}
