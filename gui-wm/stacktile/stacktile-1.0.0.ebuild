# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="stacktile is a layout generator for the river Wayland compositor."
HOMEPAGE="https://sr.ht/~leon_plickat/stacktile/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~leon_plickat/stacktile"
else
	SRC_URI="https://git.sr.ht/~leon_plickat/stacktile/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

# No tests
RESTRICT="test"

DEPEND="
	dev-libs/wayland
"
RDEPEND="
	${DEPEND}
	gui-wm/river
"
BDEPEND="
	dev-util/wayland-scanner
"

src_prepare() {
	sed -i 's/CFLAGS=/CFLAGS+=/' Makefile || die
	eapply_user
}

src_install() {
	dobin stacktile
	doman stacktile.1
}
