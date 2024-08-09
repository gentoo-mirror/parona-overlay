# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Header only C++11 tiny glTF 2.0 library"
HOMEPAGE="https://github.com/syoyo/tinygltf"
SRC_URI="
	https://github.com/syoyo/tinygltf/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples"

DEPEND="
	examples? (
		media-libs/glew:=
		media-libs/glfw
		media-libs/glu
		virtual/opengl
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DTINYGLTF_BUILD_LOADER_EXAMPLE=$(usex examples)
		-DTINYGLTF_BUILD_GL_EXAMPLES=$(usex examples)
		-DTINYGLTF_BUILD_VALIDATOR_EXAMPLE=$(usex examples)
		-DTINYGLTF_BUILD_BUILDER_EXAMPLE=$(usex examples)
		-DTINYGLTF_HEADER_ONLY=OFF
		-DTINYGLTF_INSTALL=ON
	)
	cmake_src_configure
}
