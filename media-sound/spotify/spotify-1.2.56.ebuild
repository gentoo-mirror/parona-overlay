# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils unpacker xdg

DESCRIPTION="Spotify is a social music platform"
HOMEPAGE="https://www.spotify.com/download/linux/"
SRC_BASE="http://repository.spotify.com/pool/non-free/s/spotify-client/"
BUILD_ID_AMD64="502.ga68d2d4f"
SRC_URI="${SRC_BASE}${PN}-client_${PV}.${BUILD_ID_AMD64}_amd64.deb"
S="${WORKDIR}/"

LICENSE="Spotify"
SLOT="0"
IUSE="local-playback pax-kernel"
RESTRICT="mirror strip"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libayatana-appindicator
	dev-libs/libdbusmenu
	dev-libs/nspr
	dev-libs/nss
	dev-python/dbus-python
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/harfbuzz
	media-libs/mesa[X(+)]
	net-print/cups[ssl(+)]
	sys-apps/dbus
	sys-devel/gcc
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	local-playback? ( media-video/ffmpeg:0/56.58.58 )
"

QA_PREBUILT="
	opt/spotify/spotify-client/spotify
	opt/spotify/spotify-client/libEGL.so
	opt/spotify/spotify-client/libGLESv2.so
	opt/spotify/spotify-client/libcef.so
	opt/spotify/spotify-client/libvk_swiftshader.so
	opt/spotify/spotify-client/libvulkan.so.1
	opt/spotify/spotify-client/swiftshader/libEGL.so
	opt/spotify/spotify-client/swiftshader/libGLESv2.so
"

src_install() {
	SPOTIFY_PKG_HOME=usr/share/spotify
	insinto /usr/share/pixmaps
	doins ${SPOTIFY_PKG_HOME}/icons/*.png

	# install in /opt/spotify
	SPOTIFY_HOME=/opt/spotify/spotify-client
	insinto ${SPOTIFY_HOME}
	doins -r ${SPOTIFY_PKG_HOME}/*
	fperms +x ${SPOTIFY_HOME}/spotify

	newbin - ${PN} <<-EOF
	#!/bin/sh

	export LD_LIBRARY_PATH="/usr/$(get_libdir)/apulse"

	if command -v spotify-dbus.py > /dev/null; then
	  echo "Launching spotify with Gnome systray integration."
	  spotify-dbus.py "\$@"
	else
	  if pgrep -f "Spotify/[0-9].[0-9].[0-9]" > /dev/null; then
	    busline="org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri ${1}"
	    echo "Spotify is already running"
	    echo "Sending \${busline} to dbus"
	    if command -v qdbus &> /dev/null; then
	      qdbus \$busline
	      exit
	    fi
	    if command -v dbus-send &> /dev/null; then
	      dbus-send \$busline
	      exit
	    fi
	    echo "No bus dispatcher found."
	  else
	    echo "Neither gnome-integration-spotify nor spotify-tray are installed."
	    echo "Launching spotify without systray integration."
	    exec "${SPOTIFY_HOME}/spotify" \\
	      --enable-features=UseOzonePlatfrom --ozone-platform-hint=auto --enable-wayland-ime "\$@"
	  fi
	fi
	EOF

	local size
	for size in 16 22 24 32 48 64 128 256 512; do
		newicon -s ${size} "${S}${SPOTIFY_PKG_HOME}/icons/spotify-linux-${size}.png" \
			"spotify-client.png"
	done
	domenu "${S}${SPOTIFY_PKG_HOME}/spotify.desktop"
	if use pax-kernel; then
		#create the headers, reset them to default, then paxmark -m them
		pax-mark C "${ED}${SPOTIFY_HOME}/${PN}" || die
		pax-mark z "${ED}${SPOTIFY_HOME}/${PN}" || die
		pax-mark m "${ED}${SPOTIFY_HOME}/${PN}" || die
		eqawarn "You have set USE=pax-kernel meaning that you intend to run"
		eqawarn "${PN} under a PaX enabled kernel.	To do so, we must modify"
		eqawarn "the ${PN} binary itself and this *may* lead to breakage!  If"
		eqawarn "you suspect that ${PN} is being broken by this modification,"
		eqawarn "please open a bug."
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	ewarn "If Spotify crashes after an upgrade its cache may be corrupt."
	ewarn "To remove the cache:"
	ewarn "rm -rf ~/.cache/spotify"
}
