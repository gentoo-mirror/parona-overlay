# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pure C embeddable compiler backend"
HOMEPAGE="https://c9x.me/compile/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://c9x.me/qbe.git"
else
	SRC_URI="https://c9x.me/compile/release/qbe-${PV}.tar.xz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

DOCS=("README" "doc")

src_prepare() {
	eapply_user
	sed -i 's/= $(CPPFLAGS)/+=/' Makefile || die
}

src_install() {
	emake PREFIX="${ED}/usr" install
	einstalldocs
}

src_test() {
	emake check
}
