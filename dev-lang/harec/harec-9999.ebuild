# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Hare compiler written in C11 for POSIX-compatible systems."
HOMEPAGE="https://sr.ht/~sircmpwn/hare/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/harec"
else
	COMMIT="8da848e1419c15c448e91f5c0fe987162784b572" #2022-06-28
	SRC_URI="https://git.sr.ht/~sircmpwn/harec/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	sys-devel/qbe
"

DOCS=( "README.md" "docs" )

src_configure() {
	./configure --prefix="${EPREFIX}"/usr --mandir="${EPREFIX}"/usr/share/man --sysconfdir="${EPREFIX}"/etc --libdir="${EPREFIX}"/usr/lib$(get_libdir) || die
}

src_test() {
	emake check
}
