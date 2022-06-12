# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit desktop python-single-r1 systemd

DESCRIPTION="Container-based approach to boot a full Android system"
HOMEPAGE="https://waydro.id/"
SRC_URI="https://github.com/waydroid/waydroid/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/gbinder[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	')
	app-containers/lxc[tools]
"
BDEPEND="${RDEPEND}"

src_prepare() {
	eapply_user
	python_fix_shebang waydroid.py tools
	sed -i 's:/usr/lib/waydroid/data/AppIcon.png:waydroid:' data/Waydroid.desktop || die
}

src_install() {
	insinto /opt/waydroid
	doins -r tools

	insinto /opt/waydroid/data
	doins -r data/configs data/scripts

	exeinto /opt/waydroid
	doexe waydroid.py

	dosym ${EPREFIX}/opt/waydroid/waydroid.py ${EPREFIX}/usr/bin/waydroid

	insinto /etc/gbinder.d
	doins gbinder/anbox.conf

	systemd_dounit debian/waydroid-container.service

	domenu data/Waydroid.desktop
	newicon data/AppIcon.png waydroid.png
}
