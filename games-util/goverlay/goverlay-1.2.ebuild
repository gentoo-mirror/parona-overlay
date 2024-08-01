# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multiprocessing xdg

DESCRIPTION="Graphical UI to help manage Linux overlays."
HOMEPAGE="https://github.com/benjamimgois/goverlay"
SRC_URI="
	https://github.com/benjamimgois/goverlay/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
"

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

	#TODO: doesnt work
	# Disable stripping
	sed -i \
		-e 's|<StripSymbols Value="True"/>|<StripSymbols Value="False"/>|' \
		goverlay.lpi || die

	sed -i -e 's|/sbin/ip|ip|' overlayunit.pas || die
}

#src_configure() {
#	#TODO: optimization flags?
#	cat <<-EOF > fpc.cfg
#	-veiw
#	EOF
#}

src_compile() {
	emake LAZBUILDOPTS="--max-process-count=$(get_makeopts_jobs) --lazarusdir=/usr/share/lazarus/"
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" install
	einstalldocs
}
