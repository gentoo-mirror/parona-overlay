# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A JSON terminal UI made in C++"
HOMEPAGE="https://github.com/ArthurSonzogni/json-tui"
SRC_URI="
	https://github.com/ArthurSonzogni/json-tui/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
#RESTRICT="!test? ( test )"
RESTRICT="test" # broken tests

COMMON_DEPEND="
	dev-cpp/args
	dev-cpp/nlohmann_json
	>=gui-libs/ftxui-6:=
"
DEPEND="
	${COMMON_DEPEND}
	test? (
		dev-cpp/gtest
	)
"
RDEPEND="${COMMON_DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DJSON_TUI_BUILD_TESTS=$(usex test)
		-DJSON_TUI_CLANG_TIDY=OFF
	)
	cmake_src_configure
}
