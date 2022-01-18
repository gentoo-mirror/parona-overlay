# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: zig.eclass
# @MAINTAINER:
# Alfred Wingate <parona@protonmail.com>
# @AUTHOR:
# Alfred Wingate <parona@protonmail.com>
# @SUPPORTED_EAPIS: 8
# @BLURB:
# @DESCRIPTION:

if [[ ! ${_ZIG_ECLASS} ]]; then

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

_ZIG_ECLASS=1
fi

zig_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	local zigargs=(
		zig build
		-Drelease-safe
		--verbose --verbose-cc
	)
	zigargs+=(
		${ezigargs[@]}
	)

	echo ${zigargs[@]}
	${zigargs[@]} || die
}

zig_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	pushd zig-out > /dev/null

	if [[ -d bin ]]; then
		dobin bin/*
	fi

	if [[ -d lib ]]; then
		pushd lib > /dev/null
		[[ -f *.so ]] && dolib.so $(find . -name "*.so")
		[[ -f *.a ]] && dolib.a $(find . -name "*.a")
		popd > /dev/null
	fi

	if [[ -d share ]]; then
		insinto /usr
		doins -r share
	fi

	popd > /dev/null
}
