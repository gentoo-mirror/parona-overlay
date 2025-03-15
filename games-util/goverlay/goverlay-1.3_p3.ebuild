# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multiprocessing xdg

MY_PV="${PV/_p/-}"

DESCRIPTION="Graphical UI to help manage Linux overlays."
HOMEPAGE="https://github.com/benjamimgois/goverlay"
SRC_URI="
	https://github.com/benjamimgois/goverlay/archive/refs/tags/${MY_PV}.tar.gz
		-> ${PN}-${MY_PV}.tar.gz
"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# tests not applicable downstream
FEATURES="test"

DEPEND="
	dev-libs/libqt6pas:=
	x11-libs/libX11
"
RDEPEND="
	${DEPEND}
	app-shells/bash
	dev-util/vulkan-tools
	games-util/mangohud
	media-gfx/vkBasalt
	sys-apps/iproute2
	x11-apps/mesa-progs
"
BDEPEND="
	dev-lang/lazarus[qt6(-)]
"

QA_FLAGS_IGNORED=".*"

src_prepare() {
	default

	# Disable stripping
	sed -i -e '/<Linking>/,/<\/Linking>/ { /<Debugging>/,/<\/Debugging>/d }' goverlay.lpi || die

	sed -i -e 's|/sbin/ip|ip|' overlayunit.pas || die
}

src_configure() {
	export lazbuildopts=(
		--max-process-count=$(get_makeopts_jobs)
		--verbose
		--lazarusdir=/usr/share/lazarus/
		${MY_LAZBUILDOPTS}
	)

	#TODO: ability to give flags to FPC by the user?
}

src_compile() {
	emake LAZBUILDOPTS="${lazbuildopts[*]}"
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" install
	einstalldocs
}
