# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="Next-gen init and service-manager written in Rust"
HOMEPAGE="https://github.com/rinit-org/rinit"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rinit-org/rinit"
else
	die
fi

LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	>=dev-lang/rust-1.60[nightly]
	dev-util/rinstall
"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		default_src_unpack
	fi
}

src_install() {
	rinstall install --prefix="${ED}" --system -y || die
	rm "${ED}/var/rinstall/rinit.pkg" || die
}
