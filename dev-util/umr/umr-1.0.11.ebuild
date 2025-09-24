# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( 18 19 20 21 )

inherit bash-completion-r1 cmake edo flag-o-matic linux-info llvm-r2

DESCRIPTION="umr is a userspace debugging and diagnostic tool for AMD GPUs"
HOMEPAGE="https://gitlab.freedesktop.org/tomstdenis/umr/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/tomstdenis/umr.git"
else
	SRC_URI="https://gitlab.freedesktop.org/tomstdenis/umr/-/archive/${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64"
fi

LICENSE="MIT NCSA-AMD"
SLOT="0"

#todo:
#* imgui creates files in working directory

IUSE="gui test-install"

DEPEND="
	media-libs/libglvnd
	media-libs/mesa[opengl]
	sys-libs/ncurses:=
	x11-libs/libdrm
	x11-libs/libpciaccess
	$(llvm_gen_dep '
		llvm-core/llvm:${LLVM_SLOT}=
	')
	gui? ( media-libs/libsdl2 )
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
	append-flags -fno-strict-aliasing
	#append-flags -Wno-error=strict-aliasing

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF # static libraries hard expected
		-DUMR_NO_DRM=OFF
		-DUMR_NO_LLVM=OFF
		-DUMR_STATIC_EXECUTABLE=OFF
		-DUMR_STATIC_LLVM=OFF
		-DUMR_GUI=$(usex gui)
		-DUMR_INSTALL_DEV=ON
		-DUMR_INSTALL_TEST=$(usex test-install)
		-DUMR_SERVER=ON
		-DOpenGL_GL_PREFERENCE=GLVND
		-DCMAKE_DISABLE_FIND_PACKAGE_bash-completion=ON
	)
	cmake_src_configure
}

src_test() {
	# Run only the simple KAT tests. The complicated KAT tests get hung up on probable false positives
	edo "${BUILD_DIR}"/src/test/umrtest test/vm/
}

src_install() {
	cmake_src_install

	bashcomp_alias umr umrgui
	#if use gui; then
#	fi
}
