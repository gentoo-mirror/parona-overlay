# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit desktop python-single-r1 systemd

DESCRIPTION="Container-based approach to boot a full Android system"
HOMEPAGE="https://waydro.id/"
SRC_URI="https://github.com/waydroid/waydroid/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"
IUSE="nftables"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/gbinder[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	')
	app-emulation/anbox-modules
	app-containers/lxc[tools]
"
BDEPEND="${RDEPEND}"

src_prepare() {
	eapply_user
	python_fix_shebang waydroid.py tools
}

src_compile() {
	:
}

src_install() {
	emake \
		DESTDIR="${D}" USE_SYSTEMD=1 USE_DBUS_ACTIVATION=1 USE_NFTABLES=$(usex nftables 1 0) \
		install install_apparmor
}
