# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
inherit meson python-any-r1

MY_PV1="${PV/_p/-}"
MY_PV2="$(ver_cut 1-3)"

DESCRIPTION="Overlay for monitoring FPS, temperatures, CPU/GPU load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"
SRC_URI="https://github.com/flightlessmango/MangoHud/releases/download/v${MY_PV1}/MangoHud-v${MY_PV1}-Source.tar.xz"
S="${WORKDIR}/MangoHud-v${MY_PV2}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="dbus test wayland +X"

REQUIRED_USE="|| ( wayland X )"
RESTRICT="!test? ( test )"

CDEPEND="
	dev-cpp/nlohmann_json:=
	dev-libs/libfmt:=
	dev-libs/spdlog:=
	media-libs/glew:=
	media-libs/glfw
	media-libs/libglvnd
	X? ( x11-libs/libX11 )
"
DEPEND="
	${CDEPEND}
	dbus? ( sys-apps/dbus:= )
	test? ( dev-util/cmocka )
	wayland? ( dev-libs/wayland:= )
"
RDEPEND="${CDEPEND}"
BDEPEND="
	dev-util/glslang
	$(python_gen_any_dep '
		dev-python/mako[${PYTHON_USEDEP}]
	')
	${PYTHON_DEPS}
	test? (
		dev-libs/appstream
	)
"

python_check_deps() {
	python_has_version "dev-python/mako[${PYTHON_USEDEP}]"
}

src_prepare() {
	eapply "${FILESDIR}/mango-${PV}_gcc13_cstdint_header.patch"
	eapply_user

	# Install documents into versioned dir
	sed -i "s/'doc', 'mangohud'/'doc', '${P}'/" data/meson.build || die

	# Use system cmocka
	sed -i \
		-e "/cmocka_dep =/d" \
		-e "s/cmocka = subproject('cmocka')/cmocka_dep = dependency('cmocka')/" \
		meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature X with_x11)
		$(meson_feature dbus with_dbus)
		$(meson_feature test tests)
		$(meson_feature wayland with_wayland)
		-Dappend_libdir_mangohud=true
		-Dglibcxx_asserts=false
		-Dinclude_doc=true
		-Dmangoapp=true
		-Dmangoapp_layer=true
		-Dmangohudctl=true
		-Duse_system_spdlog=enabled
		-Dwith_xnvctrl=disabled
	)

	meson_src_configure
}
