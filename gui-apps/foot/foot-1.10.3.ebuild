# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson xdg

DESCRIPTION="A fast, lightweight and minimalistic Wayland terminal emulator"
HOMEPAGE="https://codeberg.org/dnkl/foot"
SRC_URI="https://codeberg.org/dnkl/foot/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+doc +ime +grapheme-clustering pgo +themes"

#threads
#epoll

DEPEND="
	>=dev-libs/tllist-1.0.4
	dev-libs/wayland
	dev-libs/wayland-protocols
	media-libs/fontconfig
	>=gui-libs/fcft-2.4.0
	<gui-libs/fcft-3.0.0
	>=x11-libs/libxkbcommon-1.0.0
	x11-libs/pixman
	grapheme-clustering? (
		dev-libs/libutf8proc
	)
"
RDEPEND="
	${DEPEND}
	|| (
		>=sys-libs/ncurses-6.3
		gui-apps/foot-terminfo
	)
"
BDEPEND="
	dev-util/wayland-scanner
	doc? ( app-text/scdoc )
	pgo? (
		|| (
			gui-wm/cage
			>=gui-wm/sway-1.6.2
		)
	)
"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i "/install_data/,/install_dir/ s/'${PN}'/'${PF}'/" meson.build || die
	default
}

src_configure() {
	if [[ "${CC}" == "clang" ]]; then
		append-cflags -Wno-ignored-optimization-argument
	fi
	local emesonargs=(
		-Dterminfo=disabled
		$(meson_use themes)
		$(meson_feature doc docs)
		$(meson_use ime)
		$(meson_feature grapheme-clustering grapheme-clustering)
	)
	meson_src_configure
}

src_compile() {
	if use pgo; then
		meson configure "${BUILD_DIR}" -Db_pgo=generate || die
		meson_src_compile
		local OLD_SANDBOX_ON="${SANDBOX_ON}"
		export SANDBOX_ON="0"
		if command -v cage > /dev/null; then
			./pgo/full-headless-cage.sh "${S}" "${BUILD_DIR}" || die
		elif command -v sway > /dev/null; then
			./pgo/full-headless-sway.sh "${S}" "${BUILD_DIR}" || die
		else
			die "PGO requires cage or sway"
		fi
		export SANDBOX_ON="${OLD_SANDBOX_ON}"
		if [[ "${CC}" == "clang" ]]; then
				llvm-profdata merge "${BUILD_DIR}"/default_*.profraw \
					--output="${BUILD_DIR}"/default.profdata || die
		fi
		meson configure "${BUILD_DIR}" -Db_pgo=use || die
	fi
	meson_src_compile
}
