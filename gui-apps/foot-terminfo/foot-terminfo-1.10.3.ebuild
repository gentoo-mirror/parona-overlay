# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Terminfo for gui-apps/foot"
HOMEPAGE="https://codeberg.org/dnkl/foot"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/foot"
else
	SRC_URI="https://codeberg.org/dnkl/foot/archive/${PV}.tar.gz -> foot-${PV}.tar.gz"
	S="${WORKDIR}/foot"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

BDEPEND="sys-libs/ncurses"

RESTRICT="test"

src_prepare() {
	mkdir -v terminfo || die "Failed to create terminfo directory"
	sed -i "s/@default_terminfo@/foot/" foot.info || die
	default
}

src_configure() {
	:
}

src_compile() {
	tic -sxo terminfo foot.info || die "Failed to translate terminfo file"
}

src_install() {
	insinto "/usr/share/foot"
	doins -r terminfo

	newenvd - "51${PN}" <<-_EOF_
		TERMINFO_DIRS="/usr/share/foot/terminfo"
		COLON_SEPARATED="TERMINFO_DIRS"
	_EOF_
}

pkg_postinst() {
	ewarn "Please run env-update and then source /etc/profile in any open shells"
	ewarn "to update terminfo settings. Relogin to update it for any new shells."
}
