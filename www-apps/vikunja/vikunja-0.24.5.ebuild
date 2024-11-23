# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

#$ cd /path/to/project
#$ GOMODCACHE="${PWD}"/go-mod go mod download -modcacherw
#$ XZ_OPT='-T0 -9' tar -acf project-1.0-deps.tar.xz go-mod

#$ cd /path/to/project/frontend
#$ pnpm install
#$ pnpm run build
#$ XZ_OPT='-T0 -9' tar -acf project-1.0-dist.tar.xz dist

DESCRIPTION="The to-do app to organize your life."
HOMEPAGE="
	https://vikunja.io/
	https://kolaente.dev/vikunja/vikunja/
"
SRC_URI="
	https://kolaente.dev/vikunja/vikunja/archive/v${PV}.tar.gz
		-> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/32909921/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
	https://gitlab.com/api/v4/projects/32909921/packages/generic/${PN}/${PV}/${P}-dist.tar.xz
"
S="${WORKDIR}/${PN}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="
	acct-group/vikunja
	acct-user/vikunja
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	dev-build/mage
"

src_prepare() {
	default
	sed -i -e "s/\(version\), err := .*/\1 := \"${PV}\"/" -e '/version :=/a\\terr := error(nil)' magefile.go || die
	sed -i \
		-e "s|\(WorkingDirectory=\)/opt/vikunja|\1${EPREFIX}/var/lib/vikunja|" \
		-e "s|\(ExecStart=\)/usr/local/bin/vikunja|\1${EPREFIX}/usr/bin/vikunja|" \
		vikunja.service || die

	mv "${WORKDIR}/dist" "${S}/frontend/dist" || die
}

src_compile() {
	set -- mage build
	einfo ${@}
	${@} || die
}

src_test() {
	local -x VIKUNJA_SERVICE_ROOTPATH="${S}"
	local -x UNIT_TESTS_VERBOSE=1
	set -- mage test:unit
	einfo ${@}
	${@} || die
	set -- mage test:integration
	einfo ${@}
	${@} || die
}

src_install() {
	dobin vikunja
	einstalldocs

	newconfd "${FILESDIR}"/vikunja.confd vikunja
	newinitd "${FILESDIR}"/vikunja.initd vikunja
	systemd_dounit vikunja.service

	insinto /usr/share/vikunja
	doins config.yml.sample
}
