# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ALTERNATIVES=(
	"info-zip:>=app-arch/unzip-6.0_p27-r2"
	"libarchive:>=app-arch/libarchive-3.7.3"
)

inherit app-alternatives

DESCRIPTION="Unzip symlink"

RDEPEND="
	!<app-arch/unzip-6.0_p27-r2
"

src_install() {
	case $(get_alternative) in
		info-zip)
			dosym info-unzip /usr/bin/unzip
			newman - unzip.1 <<<".so info-unzip.1"
			;;
		libarchive)
			dosym bsdunzip /usr/bin/unzip
			newman - unzip.1 <<<".so bsdunzip.1"
			;;
	esac
}
