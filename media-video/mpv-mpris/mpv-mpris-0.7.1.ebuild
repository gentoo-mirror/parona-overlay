# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="MPRIS plugin for mpv"
HOMEPAGE="https://github.com/hoyon/mpv-mpris"
SRC_URI="https://github.com/hoyon/mpv-mpris/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

DEPEND="
	dev-libs/glib[dbus]
	media-video/mpv[cplugins,libmpv,lua]
"
RDEPEND="${DEPEND}"

src_install() {
	emake PREFIX="${ED}/usr" SYS_SCRIPTS_DIR="${ED}/etc/mpv/scripts" install-system
}
