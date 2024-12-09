# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A simple header-only C++ argument parser library"
HOMEPAGE="https://github.com/Taywee/args"
SRC_URI="
	https://github.com/Taywee/args/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DARGS_BUILD_EXAMPLE=OFF #todo
		-DARGS_BUILD_UNITTESTS=$(usex test)
	)
	cmake_src_configure
}
