# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Hjson for C++"
HOMEPAGE="https://hjson.github.io/"
SRC_URI="
	https://github.com/hjson/hjson-cpp/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DHJSON_ENABLE_TEST=$(usex test)
		-DHJSON_ENABLE_PERFTEST=OFF
		-DHJSON_ENABLE_INSTALL=ON
		-DHJSON_VERSIONED_INSTALL=ON
		-DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=OFF
	)

	cmake_src_configure
}

src_test() {
	cmake_build runtest
}
