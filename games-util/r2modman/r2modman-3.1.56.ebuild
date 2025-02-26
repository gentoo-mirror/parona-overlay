# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB es-419 es et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk
	sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 desktop unpacker xdg

DESCRIPTION="A simple and easy to use mod manager for several games using Thunderstore"
HOMEPAGE="https://github.com/ebkr/r2modmanPlus"
SRC_URI="https://github.com/ebkr/r2modmanPlus/releases/download/v${PV}/r2modman_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

REQUIRED_USE="elibc_glibc"

RESTRICT="strip test"

QA_PREBUILT="*"

DESTDIR="/opt/${PN}"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
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
	x11-terms/xterm
"

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	pushd "opt/r2modman/locales" >/dev/null || die
	chromium_remove_language_paks
	popd >/dev/null || die
}

src_install() {
	pushd "opt/r2modman" >/dev/null || die

	exeinto "${DESTDIR}"
	doexe r2modman chrome-sandbox libEGL.so libffmpeg.so libGLESv2.so libvk_swiftshader.so libvulkan.so.1

	insinto "${DESTDIR}"
	doins chrome_100_percent.pak chrome_200_percent.pak icudtl.dat resources.pak snapshot_blob.bin \
		v8_context_snapshot.bin vk_swiftshader_icd.json

	insopts -m0755
	doins -r locales resources

	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fowners root "${DESTDIR}/chrome-sandbox"
	fperms 4711 "${DESTDIR}/chrome-sandbox"

	# Crashpad is included in the package once in a while and when it does, it must be installed.
	# See #903616 and #890595
	[[ -x chrome_crashpad_handler ]] && doins chrome_crashpad_handler

	newbin - r2modman <<-EOF
	#!/usr/bin/env sh
	# https://gitlab.com/Parona/parona-overlay/-/issues/1
	GDK_BACKEND=x11 exec "${DESTDIR}/r2modman"
	EOF

	popd >/dev/null || die

	sed -i -e "/Exec=/ s|${DESTDIR}/||" usr/share/applications/r2modman.desktop || die
	domenu usr/share/applications/r2modman.desktop

	for size in {16,24,32,48,64,96,128,192,256}; do
		doicon -s ${size} usr/share/icons/hicolor/${size}x${size}/apps/r2modman.png
	done
}
