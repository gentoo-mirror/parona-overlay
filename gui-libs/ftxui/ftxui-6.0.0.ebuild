# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ Functional Terminal User Interface"
HOMEPAGE="https://github.com/ArthurSonzogni/FTXUI"
SRC_URI="
	https://github.com/ArthurSonzogni/FTXUI/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/${P^^}"

LICENSE="MIT"
SLOT="0/$(ver_cut 1)"
KEYWORDS="~amd64"

IUSE="doc test"
RESTRICT="!test? ( test )"

DEPEND="
	test? (
		dev-cpp/gtest
	)
"
BDEPEND="
	doc? (
		app-text/doxygen
	)
"

src_prepare() {
	cmake_src_prepare

	sed -i -e '/include(cmake\/ftxui_benchmark.cmake)/d' CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DFTXUI_QUIET=OFF
		-DFTXUI_BUILD_EXAMPLES=OFF #todo
		-DFTXUI_BUILD_DOCS=$(usex doc)
		-DFTXUI_BUILD_TESTS=$(usex test)
		-DFTXUI_BUILD_TESTS_FUZZER=OFF
		-DFTXUI_ENABLE_INSTALL=ON
		-DFTXUI_CLANG_TIDY=OFF
		-DFTXUI_ENABLE_COVERAGE=OFF
		-DFTXUI_DEV_WARNINGS=OFF
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	use doc && cmake_build doc
}

src_install() {
	cmake_src_install

	if use doc; then
		HTML_DOCS="${BUILD_DIR}/doc/doxygen/html"
	fi

	einstalldocs
}
