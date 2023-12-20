# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517=setuptools
inherit desktop distutils-r1 xdg

APPNAME="net.davidotek.pupgui2"

DESCRIPTION="Install and manage proton with Steam and Lutris"
HOMEPAGE="
	https://davidotek.github.io/protonup-qt
	https://github.com/DavidoTek/ProtonUp-Qt
"
SRC_URI="https://github.com/DavidoTek/ProtonUp-Qt/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ProtonUp-Qt-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

RDEPEND="
		>=dev-python/pyside6-6.3.0[designer,gui,widgets,${PYTHON_USEDEP}]
		>=dev-python/requests-2.27.0[${PYTHON_USEDEP}]
		>=dev-python/vdf-3.4[${PYTHON_USEDEP}]
		dev-python/inputs[${PYTHON_USEDEP}]
		>=dev-python/pyxdg-0.27[${PYTHON_USEDEP}]
		>=dev-python/steam-1.4.4[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		>=dev-python/zstandard-0.19.0[${PYTHON_USEDEP}]
"

src_prepare() {
	eapply_user

	# User friendly'er executable name
	sed -i "s/Exec=${APPNAME}/Exec=${PN}/" share/applications/${APPNAME}.desktop || die

	sed -i \
		-e '/PySide6-Essentials/d' \
		-e 's/PyYAML==6.0/PyYAML/' \
		setup.cfg || die
}

python_install() {
	distutils-r1_python_install

	python_newscript - ${PN} <<-EOF
	#!{EPREFIX}/usr/bin/python
	from pupgui2.pupgui2 import main
	main()
	EOF
}

python_install_all() {
	distutils-r1_python_install_all

	domenu share/applications/${APPNAME}.desktop

	for size in {64,128,256}; do
		doicon -s ${size} share/icons/hicolor/${size}x${size}/apps/${APPNAME}.png
	done
}
