# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"
PYTHON_COMPAT=( python3_{11..13} )
UPDATE_DISABLER_COMMIT="2f26748a667045d26bc19841f1a731b4be7a7514"

inherit chromium-2 desktop linux-info optfeature python-single-r1 unpacker xdg

DESCRIPTION="All-in-one voice and text chat for gamers"
HOMEPAGE="https://discordapp.com"
SRC_URI="
	https://dl.discordapp.net/apps/linux/${PV}/${P}.tar.gz
	https://github.com/flathub/com.discordapp.Discord/raw/${UPDATE_DISABLER_COMMIT}/disable-breaking-updates.py
		-> discord-disable-breaking-updates-${UPDATE_DISABLER_COMMIT}.py
"
S="${WORKDIR}/Discord"

LICENSE="all-rights-reserved"
SLOT="0"

IUSE="+seccomp"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="bindist mirror strip test"

RDEPEND="
	${PYTHON_DEPS}
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	sys-devel/gcc
	sys-libs/glibc
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
"

DESTDIR="/opt/${PN}"

QA_PREBUILT="*"

CONFIG_CHECK="~USER_NS"

src_unpack() {
	unpack ${P}.tar.gz
	cp "${DISTDIR}/discord-disable-breaking-updates-${UPDATE_DISABLER_COMMIT}.py" "disable-breaking-updates.py" || die
}

src_configure() {
	default
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	# remove post-install script
	rm postinst.sh || die "the removal of the unneeded post-install script failed"
	# cleanup languages
	pushd "locales/" >/dev/null || die "location change for language cleanup failed"
	chromium_remove_language_paks
	popd >/dev/null || die "location reset for language cleanup failed"
	# fix .desktop exec location
	sed -i "/Exec/s:/usr/share/discord/Discord:${PN}:" \
		"${PN}.desktop" ||
		die "fixing of exec location on .desktop failed"
}

src_install() {
	doicon -s 256 "${PN}.png"

	# install .desktop file
	domenu "${PN}.desktop"

	exeinto "${DESTDIR}"

	doexe Discord chrome-sandbox libEGL.so libffmpeg.so libGLESv2.so libvk_swiftshader.so

	insinto "${DESTDIR}"
	doins chrome_100_percent.pak chrome_200_percent.pak icudtl.dat resources.pak snapshot_blob.bin v8_context_snapshot.bin
	insopts -m0755
	doins -r locales resources

	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fowners root "${DESTDIR}/chrome-sandbox"
	fperms 4711 "${DESTDIR}/chrome-sandbox"

	# Crashpad is included in the package once in a while and when it does, it must be installed.
	# See #903616 and #890595
	[[ -x chrome_crashpad_handler ]] && doins chrome_crashpad_handler

	newbin - ${PN} <<-EOF
	#!/bin/sh

	# https://bugs.gentoo.org/905289
	${DESTDIR}/disable-breaking-updates.py

	# https://bugs.gentoo.org/935153
	${DESTDIR}/Discord $(usev !seccomp --disable-seccomp-filter-sandbox) \\
		--enable-features=UseOzonePlatfrom --ozone-platform-hint=auto \\
		--enable-wayland-ime
	EOF

	# https://bugs.gentoo.org/905289
	doins "${WORKDIR}/disable-breaking-updates.py"
	python_fix_shebang "${ED}/${DESTDIR}/disable-breaking-updates.py"
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature_header "Install the following packages for additional support:"
	optfeature "sound support" \
		media-sound/pulseaudio media-sound/apulse[sdk] media-video/pipewire
	optfeature "emoji support" media-fonts/noto-emoji
}
