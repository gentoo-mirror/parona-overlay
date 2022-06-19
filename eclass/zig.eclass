# Copyright 2022 Gentoo Authors
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

if [[ ! ${_ZIG_ECLASS} ]]; then

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

_ZIG_ECLASS=1

EXPORT_FUNCTIONS src_compile src_install src_test

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

zig_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	ezig build --verbose -Drelease-safe ${ezigargs[@]}|| die
}

zig_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	ezig build --verbose --prefix "${D}"/usr install
}

zig_src_test() {
	debug-print-function ${FUNCNAME} "$@"

	ezig build --verbose test
}

fi
