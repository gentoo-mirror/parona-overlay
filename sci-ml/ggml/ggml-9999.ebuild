# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..14} )
inherit cmake python-any-r1 toolchain-funcs

DESCRIPTION="Tensor library for machine learning"
HOMEPAGE="https://github.com/ggml-org/ggml"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ggml-org/ggml.git"
else
	# No releases but are planned
	# https://github.com/ggml-org/ggml/issues/1086
	COMMIT="b96890f3ab5ffbdbe56bc126df5366c34bd08d39"

	SRC_URI="
		https://github.com/ggml-org/ggml/archive/${COMMIT}.tar.gz
			-> ${PN}-${COMMIT}.tar.gz
	"
	S="${WORKDIR}/${PN}-${COMMIT}"

	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0/${PV}"

IUSE="blas opencl openmp test vulkan"

declare -A CPU_FEATURES=(
	[AMX_BF16]="x86"
	[AMX_INT8]="x86"
	[AMX_TILE]="x86"
	[AVX2]="x86"
	[AVX512_BF16]="x86"
	[AVX512_VBMI]="x86;avx512vbmi"
	[AVX512_VNNI]="x86"
	[AVX]="x86"
	[AVX_VNNI]="x86"
	[BMI2]="x86"
	[F16C]="x86"
	[FMA]="x86;fma3"
	[SSE42]="x86;sse4_2"
	[VSX]="ppc"
)
add_cpu_features_use() {
	for flag in ${!CPU_FEATURES[@]}; do
		IFS=$';' read -r arch use <<< ${CPU_FEATURES[${flag}]}
		IUSE+=" cpu_flags_${arch}_${use:-${flag,,}}"
	done
}
add_cpu_features_use

RESTRICT="!test? ( test )"

COMMON_DEPEND="
	blas? ( virtual/blas )
	opencl? ( virtual/opencl )
"
RDEPEND="${COMMON_DEPEND}
	media-libs/vulkan-loader
"
DEPEND="${COMMON_DEPEND}
	vulkan? ( dev-util/vulkan-headers )
"
BDEPEND="
	virtual/pkgconfig
	opencl? ( ${PYTHON_DEPS} )
	vulkan? ( dev-util/glslang )
"

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
	use opencl && python-any-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DGGML_BACKEND_DL=OFF
		-DGGML_CPU_ALL_VARIANTS=OFF

		-DGGML_NATIVE=OFF
		-DGGML_LTO=OFF
		-DGGML_CCACHE=OFF

		-DGGML_BUILD_TESTS=$(usex test)
		-DGGML_BUILD_EXAMPLES=OFF # todo

		-DGGML_BLAS=$(usex blas)
		-DGGML_OPENCL=$(usex opencl)
		-DGGML_OPENMP=$(usex openmp)
		-DGGML_VULKAN=$(usex vulkan)
		-DGGML_VULKAN_TESTS=$(usex vulkan $(usex test))

		# features
		-DGGML_AVX512=OFF # no-op on its own
		-DGGML_LASX=OFF # only appends -mlasx
		-DGGML_LSX=OFF # only appends -mlsx
		-DGGML_RVV=OFF # no-op on its own
		-DGGML_RV_ZFH=OFF # adds march
		-DGGML_XTHEADVECTOR=OFF # adds march
		-DGGML_VXE=OFF # s390x, no use flag
		-DGGML_NNPA=OFF # s390x, no use flag
	)

	if [[ ${PV} != 9999 ]]; then
		mycmakeargs+=(
			-DGGML_BUILD_NUMBER=1 # avoid git
			-DGGML_BUILD_COMMIT="${COMMIT}"
		)
	fi

	for flag in ${!CPU_FEATURES[@]}; do
		IFS=$';' read -r arch use <<< ${CPU_FEATURES[${flag}]}
		mycmakeargs+=(
			-DGGML_${flag}=$(usex cpu_flags_${arch}_${use:-${flag,,}})
		)
	done

	cmake_src_configure
}
