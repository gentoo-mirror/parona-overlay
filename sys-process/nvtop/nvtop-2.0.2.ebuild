# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="AMD and NVIDIA GPUs htop like monitoring tool"
HOMEPAGE="https://github.com/Syllo/nvtop"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Syllo/nvtop"
else
	SRC_URI="https://github.com/Syllo/nvtop/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="test video_cards_amdgpu video_cards_nvidia"
REQUIRED_USE="
	|| (
		video_cards_amdgpu
		video_cards_nvidia
	)
"
RESTRICT="!test? ( test )"

DEPEND="
	sys-libs/ncurses
	video_cards_amdgpu? (
		x11-libs/libdrm[video_cards_amdgpu] )
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers
	)
	test? (
		dev-cpp/gtest
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DAMDGPU_SUPPORT=$(usex video_cards_amdgpu)
		-DNVIDIA_SUPPORT=$(usex video_cards_nvidia)
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}
