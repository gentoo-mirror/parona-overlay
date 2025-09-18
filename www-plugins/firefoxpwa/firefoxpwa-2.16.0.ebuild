# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

declare -A GIT_CRATES=(
	[mime-parse]='https://github.com/filips123/mime;57416f447a10c3343df7fe80deb0ae8a7c77cf0a;mime-%commit%/mime-parse'
	[mime]='https://github.com/filips123/mime;57416f447a10c3343df7fe80deb0ae8a7c77cf0a;mime-%commit%'
	[web_app_manifest]='https://github.com/filips123/WebAppManifestRS;477c5bbc7406eec01aea40e18338dafcec78c917;WebAppManifestRS-%commit%'
)

RUST_MAX_VER="1.88.0"
RUST_MIN_VER="1.85.0"

inherit cargo shell-completion xdg

DESCRIPTION="A tool to install, manage and use Progressive Web Apps (PWAs) in Mozilla Firefox"
HOMEPAGE="https://pwasforfirefox.filips.si/"
SRC_URI="
	https://github.com/filips123/PWAsForFirefox/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
if [[ ${PKGBUMPING} != ${PVR} ]]; then
	SRC_URI+="
		https://gitlab.com/api/v4/projects/32909921/packages/generic/firefoxpwa/${PV}/firefoxpwa-${PV}-crates.tar.xz
	"
fi
S="${WORKDIR}/PWAsForFirefox-${PV}/native"

LICENSE="MPL-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD ISC MIT MPL-2.0
	UoI-NCSA Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	app-arch/zstd:=
	dev-libs/openssl:=
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	dev-build/cargo-make
	virtual/pkgconfig
"

QA_FLAGS_IGNORED=".*"

src_prepare() {
	default

	sed -i -E \
		-e 's/\$SUDO //' \
		-e 's/((install|mkdir|cp) .*) (\S*)$/\1 ${DESTDIR}\3/' \
		-e '/^\[tasks.install-linux\]/,/^\[/ { /dependencies = \["build"\]/d }' \
		-e "s|target/release|$(cargo_target_dir)|" \
		Makefile.toml || die

	# https://wiki.gentoo.org/wiki/Project:Rust/sys_crates
	mkdir "${T}/pkg-config" || die
	export PKG_CONFIG_PATH=${T}/pkg-config${PKG_CONFIG_PATH+:${PKG_CONFIG_PATH}}
	cat >> "${T}/pkg-config/bzip2.pc" <<-EOF || die
		Name: bzip2
		Version: 9999
		Description:
		Libs: -lbz2
	EOF

}

src_configure() {
	makers set-version ${PV} || die

	# no easy way to unvendor blake3

	export PKG_CONFIG_ALLOW_CROSS=1
	export ZSTD_SYS_USE_PKG_CONFIG=1
	export OPENSSL_NO_VENDOR=1

	cargo_src_configure --no-default-features
}

src_install() {
	local -x DESTDIR="${ED}"

	set -- cargo make install
	einfo "$@"
	"$@" || die -n "${*} failed"

	dodoc ../README.md
	newdoc ../native/README.md README-NATIVE.md
	newdoc ../extension/README.md README-EXTENSION.md

	insinto /usr/share/metainfo
	doins packages/appstream/si.filips.FirefoxPWA.metainfo.xml

	newbashcomp  $(cargo_target_dir)/completions/firefoxpwa.bash firefoxpwa
	dofishcomp $(cargo_target_dir)/completions/firefoxpwa.fish
	dozshcomp $(cargo_target_dir)/completions/_firefoxpwa
}

pkg_postinst() {
	einfo "You have successfully installed the native part of the PWAsForFirefox project"
	einfo "You should also install the Firefox extension if you haven't already"
	einfo "Download: https://addons.mozilla.org/firefox/addon/pwas-for-firefox/"

	xdg_pkg_postinst
}

pkg_postrm() {
	if [[ ! ${REPLACING_VERSIONS} ]]; then
		einfo "Runtime, profiles and web apps are still installed in user directories"
		einfo "You can remove them manually after this package is uninstalled"
		einfo "Doing that will remove all installed web apps and their data"
	fi

	xdg_pkg_postrm
}
