# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Header only C++14 mocking framework"
HOMEPAGE="https://github.com/rollbear/trompeloeil"
SRC_URI="https://github.com/rollbear/trompeloeil/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	test? (
		dev-cpp/catch:0
	)
"

src_configure() {
	local mycmakeargs=(
		-DTROMPELOEIL_BUILD_TESTS=$(usex test)
		-DTROMPELOEIL_INSTALL_TARGETS=ON
		-DTROMPELOEIL_INSTALL_DOCS=ON
	)
	cmake_src_configure
}
