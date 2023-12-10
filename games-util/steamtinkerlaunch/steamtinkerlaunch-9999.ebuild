# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature xdg

DESCRIPTION="Tool for use with the Steam client for custom launch options"
HOMEPAGE="https://github.com/sonic2kk/steamtinkerlaunch"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sonic2kk/steamtinkerlaunch"
else
	SRC_URI="https://github.com/sonic2kk/steamtinkerlaunch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

# no tests
RESTRICT="test"

RDEPEND="
	app-alternatives/awk
	app-alternatives/tar
	app-arch/unzip
	app-editors/vim-core
	app-shells/bash
	dev-vcs/git
	gnome-extra/yad
	net-misc/wget
	sys-process/procps
	x11-apps/xprop
	x11-apps/xrandr
	x11-apps/xwininfo
	x11-misc/xdotool
"

src_prepare() {
	default

	sed -i \
		-e 's|PREFIX := /usr|PREFIX := $(DESTDIR)/usr|' \
		-e "s|share/doc/${PN}|share/doc/${PF}|" \
		-e '/sed "s:^PREFIX=/d' \
		Makefile
}

pkg_postinst() {
	xdg_pkg_postinst

	# TODO: go through optional dependencies properly
	optfeature_header "Optional programs for extra features:"
	# optfeature "boxtron support" games-engines/boxtron
	optfeature "gamemode support" games-util/gamemode
	optfeature "gamescople support" gui-wm/gamescope
	optfeature "debugging" sys-devel/gdb
	optfeature "game icons and game desktop files" media-gfx/imagemagick
	optfeature "getting updated versions of Vortex" app-misc/jq
	optfeature "sending desktop notifications" x11-libs/libnotify
	optfeature "mangohud support" games-util/mangohud
	optfeature "game network activity monitoring" sys-apps/net-tools
	#optfeature "Utility for putting games and applications to sleep to free up resources." ?/nyrna
	optfeature "SpecialK archive support" app-arch/p7zip
	#pev
	#replay-sorcery?
	optfeature "backing up and restoring the steamuser folder of a Proton prefix" net-misc/rsync
	optfeature "ScummVM support" games-engines/scummvm
	optfeature "diagnostic and debugging information in game logs" dev-util/strace
	optfeature "checking if VR header is present" sys-apps/usbutils
	optfeature "vkBasalt support" media-libs/vkBasalt
	# vr-video-player
	optfeature "wine support" virtual/wine
	optfeature "winestricks support" app-emulation/winetricks
	optfeature "desktop enviroment integrations, such as opening default browser and text editors" x11-misc/xdg-utils

	optfeature "steam support" games-util/steam-launcher
	#app-arch/innoextract
	#app-arch/cabextract
	#conty.sh?
	#obs-gamecapture?
	#resetcollections?
}
