# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit meson-multilib python-single-r1 xdg

DESCRIPTION="Overlay for monitoring FPS, temperatures, CPU/GPU load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3

	VULKAN_HEADER_VER="1.2.158"
	VULKAN_HEADER_WRAP_VER="${VULKAN_HEADER_VER}-2"
	IMGUI_VER="1.89.9"
	IMGUI_WRAP="${IMGUI_VER}-2"
	IMPLOT_VER="0.16"
	IMPLOT_WRAP="${IMPLOT_VER}-1"

	EGIT_REPO_URI="https://github.com/flightlessmango/MangoHud"
	SRC_URI="
		https://github.com/KhronosGroup/Vulkan-Headers/archive/v${VULKAN_HEADER_VER}.tar.gz
			-> vulkan-headers-${VULKAN_HEADER_VER}.tar.gz
		https://wrapdb.mesonbuild.com/v2/vulkan-headers_${VULKAN_HEADER_WRAP_VER}/get_patch
			-> vulkan-headers-${VULKAN_HEADER_WRAP_VER}-wrap.zip
		https://github.com/ocornut/imgui/archive/refs/tags/v${IMGUI_VER}.tar.gz
			-> imgui-${IMGUI_VER}.tar.gz
		https://wrapdb.mesonbuild.com/v2/imgui_${IMGUI_WRAP}/get_patch
			-> imgui_${IMGUI_WRAP}_patch.zip
		https://github.com/epezent/implot/archive/refs/tags/v${IMPLOT_VER}.tar.gz
			-> implot-${IMPLOT_VER}.tar.gz
		https://wrapdb.mesonbuild.com/v2/implot_${IMPLOT_WRAP}/get_patch
			-> implot_${IMPLOT_WRAP}_patch.zip
	"
else
	SUFFIX="$(ver_cut 5)"
	MY_PV1="$(ver_cut 1-3)${SUFFIX:+-}${SUFFIX}"
	MY_PV2="$(ver_cut 1-3)"
	SRC_URI="https://github.com/flightlessmango/MangoHud/releases/download/v${MY_PV2}/MangoHud-v${MY_PV1}-Source.tar.xz"
	S="${WORKDIR}/MangoHud-v${MY_PV2}"

	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="dbus mangoapp plots test wayland +X"

REQUIRED_USE="
	|| ( wayland X )
	mangoapp? ( X )
	${PYTHON_REQUIRED_USE}
"

# tests are broken
RESTRICT="test"

CDEPEND="
	dev-cpp/nlohmann_json:=
	dev-libs/libfmt:=
	dev-libs/spdlog:=
	media-libs/glew:=
	media-libs/glfw
	media-libs/libglvnd
	x11-libs/libxkbcommon
	X? ( x11-libs/libX11 )
	wayland? ( dev-libs/wayland )
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
if [[ ${PV} == "9999" ]]; then
	BDEPEND+=" app-arch/unzip"
fi

python_check_deps() {
	python_has_version "dev-python/mako[${PYTHON_USEDEP}]"
}

src_unpack() {
	if [[ "${PV}" == "9999" ]]; then
		git-r3_src_unpack
	fi
	default
}

src_prepare() {
	default

	if [[ "${PV}" == "9999" ]]; then
		mv "${WORKDIR}/Vulkan-Headers-${VULKAN_HEADER_VER}" "${S}/subprojects/Vulkan-Headers-${VULKAN_HEADER_VER}" || die
		mv "${WORKDIR}/imgui-${IMGUI_VER}" "${S}/subprojects/imgui-${IMGUI_VER}" || die
		mv "${WORKDIR}/implot-${IMPLOT_VER}" "${S}/subprojects/implot-${IMPLOT_VER}" || die
	fi

	# Install documents into versioned dir
	sed -i "s/'doc', 'mangohud'/'doc', '${PF}'/" data/meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature X with_x11)
		$(meson_feature dbus with_dbus)
		$(meson_native_use_bool mangoapp)
		$(meson_native_use_feature plots mangoplot)
		$(meson_feature test tests)
		$(meson_feature wayland with_wayland)
		-Dappend_libdir_mangohud=true
		-Ddynamic_string_tokens=true
		-Dglibcxx_asserts=false
		-Dinclude_doc=true
		$(meson_native_true mangohudctl)
		-Duse_system_spdlog=enabled
		-Dwith_xnvctrl=disabled
		--force-fallback-for=imgui,implot
	)

	meson-multilib_src_configure
}

src_install() {
	meson-multilib_src_install

	if use plots; then
		python_optimize "${D}"
		python_fix_shebang "${D}"
	fi
}
