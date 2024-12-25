# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
inherit meson python-single-r1

SUFFIX="$(ver_cut 5)"
MY_PV1="$(ver_cut 1-3)${SUFFIX:+-}${SUFFIX}"
MY_PV2="$(ver_cut 1-3)"

DESCRIPTION="Overlay for monitoring FPS, temperatures, CPU/GPU load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"
SRC_URI="https://github.com/flightlessmango/MangoHud/releases/download/v${MY_PV2}/MangoHud-v${MY_PV1}-Source.tar.xz"
S="${WORKDIR}/MangoHud-v${MY_PV2}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="dbus mangoapp plots test wayland +X"

REQUIRED_USE="
	|| ( wayland X )
	mangoapp? ( X )
	${PYTHON_REQUIRED_USE}
"
RESTRICT="!test? ( test )"

CDEPEND="
	dev-cpp/nlohmann_json:=
	dev-libs/libfmt:=
	dev-libs/spdlog:=
	media-libs/glew:=
	media-libs/glfw
	media-libs/libglvnd
	X? ( x11-libs/libX11 )
	wayland? (
		dev-libs/wayland
		x11-libs/libxkbcommon
	)
"
DEPEND="
	${CDEPEND}
	dbus? ( sys-apps/dbus )
	test? ( dev-util/cmocka )
"
RDEPEND="
	${CDEPEND}
	${PYTHON_DEPS}
	plots? (
		$(python_gen_cond_dep '
			dev-python/matplotlib[${PYTHON_USEDEP}]
			dev-python/numpy[${PYTHON_USEDEP}]
		')
	)
"
BDEPEND="
	${PYTHON_DEPS}
	dev-util/glslang
	$(python_gen_cond_dep '
		dev-python/mako[${PYTHON_USEDEP}]
	')
	test? (
		dev-libs/appstream
		${RDEPEND}
	)
"

python_check_deps() {
	python_has_version "dev-python/mako[${PYTHON_USEDEP}]"
}

src_prepare() {
	default

	# TODO: remove on next bump
	# https://github.com/flightlessmango/MangoHud/issues/1336
	sed -i -e "s/version : 'v0.7.1'/version : 'v0.7.2'/" meson.build || die

	# Install documents into versioned dir
	sed -i "s/'doc', 'mangohud'/'doc', '${PF}'/" data/meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature X with_x11)
		$(meson_feature dbus with_dbus)
		$(meson_use mangoapp)
		$(meson_use mangoapp mangoapp_layer)
		$(meson_feature plots mangoplot)
		$(meson_feature test tests)
		$(meson_feature wayland with_wayland)
		-Dappend_libdir_mangohud=true
		-Ddynamic_string_tokens=true
		-Dglibcxx_asserts=false
		-Dinclude_doc=true
		-Dmangohudctl=true
		-Duse_system_spdlog=enabled
		-Dwith_xnvctrl=disabled
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	if use plots; then
		python_optimize "${D}"
		python_fix_shebang "${D}"
	fi
}
