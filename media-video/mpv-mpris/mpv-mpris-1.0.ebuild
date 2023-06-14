# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VIRTUALX_REQUIRED=test
inherit virtualx

DESCRIPTION="MPRIS plugin for mpv"
HOMEPAGE="https://github.com/hoyon/mpv-mpris"
SRC_URI="https://github.com/hoyon/mpv-mpris/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/glib[dbus]
	media-video/mpv[cplugins(+),libmpv,lua]
"
RDEPEND="${DEPEND}"
BDEPEND="
	test? (
		${DEPEND}
		app-misc/jq
		media-sound/playerctl
		net-misc/socat
		sys-apps/dbus
		app-alternatives/awk
		x11-themes/sound-theme-freedesktop
	)
"

src_prepare() {
	default
	sed -i '/xvfb-run --help/,/^fi/ d' test/env || die
	sed -i '/^dbus-run-session/d' test/env || die
	sed -i '/^xvfb-run/d' test/env || die
}

src_install() {
	emake PREFIX="${ED}/usr" SYS_SCRIPTS_DIR="${ED}/etc/mpv/scripts" install-system
}

src_test() {
	local dbus_params=(
		$(dbus-daemon --session --print-address --fork --print-pid)
	)
	local -x DBUS_SESSION_BUS_ADDRESS=${dbus_params[0]}

	virtx emake -j1 test

	kill "${dbus_params[1]}" || die
}
