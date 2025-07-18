# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
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

RDEPEND="
	>=dev-python/pyside-6.3.0:6[dbus,designer,gui,uitools(+),widgets,${PYTHON_USEDEP}]
	>=dev-python/requests-2.27.0[${PYTHON_USEDEP}]
	>=dev-python/vdf-4.0[${PYTHON_USEDEP}]
	dev-python/inputs[${PYTHON_USEDEP}]
	>=dev-python/pyxdg-0.27[${PYTHON_USEDEP}]
	>=dev-python/steam-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/zstandard-0.19.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		  dev-python/pytest-responses[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-responses )
distutils_enable_tests pytest

src_prepare() {
	eapply_user

	# User friendly'er executable name
	sed -i "s/Exec=${APPNAME}/Exec=${PN}/" share/applications/${APPNAME}.desktop || die

	sed -e '/PySide6-Essentials/d' \
		-i setup.cfg || die
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

python_test() {
	QT_QPA_PLATFORM="offscreen" epytest
}
