# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Port of OpenAI's Whisper model in C/C++"
HOMEPAGE="https://github.com/ggml-org/whisper.cpp"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ggml-org/whisper.cpp.git"
else
	SRC_URI="
		https://github.com/ggml-org/whisper.cpp/archive/refs/tags/v${PV}.tar.gz
			-> ${P}.tar.gz
	"
	S="${WORKDIR}/whisper.cpp-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"

IUSE="examples ffmpeg sdl test"
REQUIRED_USE="test? ( examples )"
RESTRICT="!test? ( test )"

DEPEND="
	ffmpeg? ( media-video/ffmpeg:= )
	sdl? ( media-libs/libsdl2:= )
"
if [[ ${PV} == 9999 ]]; then
	DEPEND+=" ~sci-ml/ggml-9999"
else
	DEPEND+="
		<sci-ml/ggml-0_p20250612:=
	"
fi

RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

CMAKE_SKIP_TESTS=(
	# tests cannot handle out of source build
	"test-vad"
	"test-vad-full"
)

src_configure() {
	local mycmakeargs=(
		-DWHISPER_BUILD_TESTS=$(usex test)
		-DWHISPER_BUILD_EXAMPLES=$(usex examples) # todo
		-DWHISPER_BUILD_SERVER=$(usex examples)
		-DWHISPER_CURL=OFF # does nothing
		-DWHISPER_FFMPEG=$(usex ffmpeg)
		-DWHISPER_SDL2=$(usex sdl)
		-DWHISPER_USE_SYSTEM_GGML=ON
	)
	[[ ${PV} != 9999 ]] && mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_Git=ON )
	cmake_src_configure
}
