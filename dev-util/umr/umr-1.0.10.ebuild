# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( 18 19 )

inherit cmake flag-o-matic linux-info llvm-r2

DESCRIPTION="umr is a userspace debugging and diagnostic tool for AMD GPUs"
HOMEPAGE="https://gitlab.freedesktop.org/tomstdenis/umr/"
SRC_URI="https://gitlab.freedesktop.org/tomstdenis/umr/-/archive/${PV}/${P}.tar.bz2"

LICENSE="MIT NCSA-AMD"
SLOT="0"
KEYWORDS="~amd64"

#todo:
#* conditional building and installing of umrtest
#* optional gui
#* imgui creates files in working directory

DEPEND="
	dev-libs/nanomsg:=
	media-libs/libglvnd
	media-libs/libsdl2
	media-libs/mesa[opengl]
	sys-libs/ncurses:=
	x11-libs/libdrm
	x11-libs/libpciaccess
	$(llvm_gen_dep '
		llvm-core/llvm:${LLVM_SLOT}=
	')
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

pkg_setup() {
	if kernel_is -lt 4 10; then
		# from the readme
		ewarn "It supports hardware from SI based hardware onwards and requires a v4.10 kernel"
		ewarn "or newer to function correctly.  Older kernels (not older than v4.8) may work"
		ewarn "but with limited functionality/stability.  Older kernels are not supported"
		ewarn "officially so please refrain from submitting bug reports in relation to them."
	fi

	llvm-r2_pkg_setup
}

src_prepare() {
	cmake_src_prepare

	if [[ ${PV} != 9999 ]]; then
		sed -i -e "s/^get_version_from_tag(\".*\")/get_version_from_tag(\"${PV}\")/" CMakeLists.txt || die
	fi
}

src_configure() {
	# strict-aliasing violations
	filter-lto

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DUMR_NO_DRM=OFF
		-DUMR_NO_LLVM=OFF
		-DUMR_STATIC_LLVM=OFF
		-DUMR_NEED_RT=OFF
		-DUMR_GUI=ON
		-DUMR_SERVER=ON
		-DOpenGL_GL_PREFERENCE=GLVND
		-DCMAKE_DISABLE_FIND_PACKAGE_bash-completion=ON
	)
	cmake_src_configure
}

src_test() {
	local -x UMRTESTPATH="${BUILD_DIR}/src/test/umrtest"
	local -x UMRAPPPATH="${BUILD_DIR}/src/app/umr"

	set -- bash test/runtest.sh norebuild
	einfo "${@}"
	"${@}" || die
}
