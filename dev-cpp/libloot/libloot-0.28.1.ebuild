# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"
RUST_MIN_VER="1.85.0"

inherit cargo cmake

DESCRIPTION="A library for accessing LOOT's metadata and sorting functionality (C++ wrapper)"
HOMEPAGE="
	https://loot.github.io/
	https://github.com/loot/libloot/
"

TESTING_PLUGINS_VER="1.6.2"

SRC_URI="
	https://github.com/loot/libloot/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
	test? (
		https://github.com/Ortham/testing-plugins/archive/${TESTING_PLUGINS_VER}.tar.gz
			-> testing-plugins-${TESTING_PLUGINS_VER}.tar.gz
	)
	${CARGO_CRATE_URIS}
"
if [[ ${PKGBUMPING} != ${PVR} ]]; then
	SRC_URI+="
		https://gitlab.com/api/v4/projects/32909921/packages/generic/${PN}/0.28.0/${PN}-0.28.0-crates.tar.xz
	"
fi
S="${S}/cpp"

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0 GPL-3 ISC MIT
	MPL-2.0 Unicode-3.0 ZLIB
"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	${RDEPEND}
	test? (
		dev-cpp/gtest
	)
"

CMAKE_SKIP_TESTS=(
	# Requires Turkish and Greek locales
	"CompareFilenames.shouldBeCaseInsensitiveAndLocaleInvariant"
	# Requires Greek locale
	"NormalizeFilename.shouldCaseFoldStringsAndBeLocaleInvariant"
)

src_prepare() {
	cmake_src_prepare

	# noop cargo target, we want to handle this via eclass functions
	sed -e '/^add_custom_target(libloot-cpp-build/,/^)$/d' \
		-i CMakeLists.txt || die
}
src_configure() {
	# https://github.com/loot/libloot/blob/master/README.md#build
	export LIBLOOT_REVISION="${PV}"

	cargo_src_configure

	# to match cargo
	use debug && CMAKE_BUILD_TYPE="Debug"

	local mycmakeargs=(
		-DLIBLOOT_BUILD_SHARED=ON
		-DLIBLOOT_BUILD_TESTS=$(usex test)
		-DLIBLOOT_INSTALL_DOCS=OFF # todo
		-DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
	)
	use test && mycmakeargs+=(
		-DFETCHCONTENT_TRY_FIND_PACKAGE_MODE=ALWAYS
		-DFETCHCONTENT_SOURCE_DIR_TESTING-PLUGINS="${WORKDIR}/testing-plugins-${TESTING_PLUGINS_VER}"
	)
	cargo_env cmake_src_configure
}

src_compile() {
	cargo_src_compile
	cmake_src_compile
}
