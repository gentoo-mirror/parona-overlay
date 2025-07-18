# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

COMMIT="ae47dbc402151fd1f5fcaad9d74f2d82396a2b56"

DESCRIPTION="Emacs Tramp integration for Incus containers"
HOMEPAGE="https://gitlab.com/lckarssen/incus-tramp"
SRC_URI="https://gitlab.com/lckarssen/incus-tramp/-/archive/${COMMIT}/incus-tramp-${COMMIT}.tar.bz2"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-containers/incus"
