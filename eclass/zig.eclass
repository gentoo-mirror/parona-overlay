# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: zig.eclass
# @MAINTAINER:
# Alfred Wingate <parona@protonmail.com>
# @AUTHOR:
# Alfred Wingate <parona@protonmail.com>
# @SUPPORTED_EAPIS: 8
# @BLURB: common ebuild function for zig-based packages
# @DESCRIPTION:
# This eclass contains the default phase functions for packages which
# use zig compilers build system

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

if [[ ! ${_ZIG_ECLASS} ]]; then
_ZIG_ECLASS=1

BDEPEND="dev-lang/zig"

# @FUNCTION: ezig
# @USAGE: [arg] ...
# @DESCRIPTION:
# Wrapper for zig
ezig() {
    debug-print-function ${FUNCNAME} "$@"

    ebegin "Invoking \"zig ${*}\""
    zig "${@}"
    eend $? "\"zig ${*}\" failed" || die
}

# @FUNCTION: zig_src_compile
# @DESCRIPTION:
# This is the zig_src_compile function.
zig_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	ezig build --verbose -Drelease-safe ${ezigargs[@]}|| die
}

# @FUNCTION: zig_src_install
# @DESCRIPTION:
# This is the zig_src_install function.
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

# @FUNCTION: zig_src_test
# @DESCRIPTION:
# This is the zig_src_test function.
zig_src_test() {
	debug-print-function ${FUNCNAME} "$@"

	ezig test --verbose
}

fi

EXPORT_FUNCTIONS src_compile src_install src_test
