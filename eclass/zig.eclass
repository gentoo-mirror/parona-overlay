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

# @ECLASS_VARIABLE: ZIG_MAX_VERSION
# @DEFAULT_UNSET
# @PRE_INHERIT
# @DESCRIPTION:
# Highest supported zig version for the package.

# @ECLASS_VARIABLE: ZIG_MIN_VERSION
# @DEFAULT_UNSET
# @PRE_INHERIT
# @DESCRIPTION:
# Lowest supported zig version for the package.

if [[ -n ${ZIG_MAX_VERSION} ]]; then
	_zig_max_version="${ZIG_MAX_VERSION:0:-1}$(( ${ZIG_MAX_VERSION:(-1)} + 1))"
fi

if [[ -z ${ZIG_MAX_VERSION} ]] && [[ -z ${ZIG_MIN_VERSION} ]]; then
BDEPEND="
	|| (
		dev-lang/zig-bin
		dev-lang/zig
	)
"
elif [[ ${ZIG_MAX_VERSION} == ${ZIG_MIN_VERSION} ]]; then
BDEPEND="
	|| (
		dev-lang/zig-bin:${ZIG_MAX_VERSION}
		dev-lang/zig:${ZIG_MAX_VERSION}
	)
"
elif [[ -n ${ZIG_MAX_VERSION} ]] && [[ -n ${ZIG_MIN_VERSION} ]]; then
BDEPEND="
	|| (
		<dev-lang/zig-bin-${_zig_max_version}
		>=dev-lang/zig-bin-${ZIG_MIN_VERSION}
		<dev-lang/zig-${_zig_max_version}
		>=dev-lang/zig-${ZIG_MAX_VERSION}
	)
"
elif [[ -n ${ZIG_MAX_VERSION} ]] && [[ -z ${ZIG_MIN_VERSION} ]]; then
BDEPEND="
	|| (
		<dev-lang/zig-bin-${_zig_max_version}
		<dev-lang/zig-${_zig_max_version}
	)
"
elif [[ -z ${ZIG_MAX_VERSION} ]] && [[ -n ${ZIG_MIN_VERSION} ]]; then
BDEPEND="
	|| (
		>=dev-lang/zig-bin-${ZIG_MIN_VERSION}
		>=dev-lang/zig-${ZIG_MIN_VERSION}
	)
"
fi

# @FUNCTION: ezig
# @USAGE: [arg] ...
# @DESCRIPTION:
# Wrapper for zig
ezig() {
	debug-print-function ${FUNCNAME} "$@"

	local command=${1}
	shift

	set -- ${ZIG} ${command} --global-cache-dir "${T}"/zig_vendor ${@}

	ebegin "Invoking \"${@}\""
	${@}
	eend $? "\"${@}\" failed" || die
}

# @ECLASS_VARIABLE: ZIG_VENDOR
# @DEFAULT_UNSET
# @PRE_INHERIT
# @DESCRIPTION:
# Bash associative array containing vendored zig dependencies.

# @ECLASS_VARIABLE: ZIG_VENDOR_URIS
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# List of URIs to put into SRC_URI created from ZIG_VENDOR.

# @FUNCTION: zig_vendor_uris
# @DESCRIPTION:
# Generate the URIs to put into SRC_URI to help fetch the vendored dependencies. It uses the ZIG_VENDOR variable.
zig_vendor_uris() {
	ZIG_VENDOR_URIS=

	local uri
	for dependency in ${!ZIG_VENDOR[@]}; do
		uri="${ZIG_VENDOR[${dependency}]}"
		ZIG_VENDOR_URIS+=" ${uri} -> ${dependency}-${uri##*/}"
	done
}
zig_vendor_uris

# @FUNCTION: zig_pkg_setup
# @DESCRIPTION:
# This is the zig_pkg_setup function.
zig_pkg_setup() {
	get_best_version() {
		local zig=${1}

		if [[ -z ${ZIG_MAX_VERSION} ]] && [[ -z ${ZIG_MIN_VERSION} ]]; then
			found_zig_ver="$(best_version -b ${zig})"
		elif [[ ${ZIG_MAX_VERSION} == ${ZIG_MIN_VERSION} ]]; then
			found_zig_ver="$(best_version -b ${zig}:${ZIG_MAX_VERSION})"
		elif [[ -n ${ZIG_MAX_VERSION} ]] && [[ -n ${ZIG_MIN_VERSION} ]]; then
			found_zig_ver="$(best_version -b <${zig}-${_zig_max_version})"
			if ver_test ${found_zig_ver##${zig}} -lt ${ZIG_MIN_VERSION}; then
				found_zig_ver=""
			fi
		elif [[ -n ${ZIG_MAX_VERSION} ]] && [[ -z ${ZIG_MIN_VERSION} ]]; then
			found_zig_ver="$(best_version -b <${zig}-${_zig_max_version})"
		elif [[ -z ${ZIG_MAX_VERSION} ]] && [[ -n ${ZIG_MIN_VERSION} ]]; then
			found_zig_ver="$(best_version -b >=${zig}-${ZIG_MIN_VERSION})"
		fi

		# strip category/package-
		found_zig_ver=${found_zig_ver##${zig}-}
		# strip revision
		found_zig_ver=${found_zig_ver%%-r*}

		echo ${found_zig_ver}
	}

	zig_ver="$(get_best_version dev-lang/zig-bin)"
	zig_ver="${zig_ver:-$(get_best_version dev-lang/zig)}"

	if [[ -n ${zig_ver} ]]; then
		export ZIG="$(type -P zig-${zig_ver##dev-lang/zig-})"
	else
		die "Couldn't find a valid zig version"
	fi

	export zig_ver
}


# @FUNCTION: zig_src_unpack
# @DESCRIPTION:
# This is the zig_src_unpack function.
zig_src_unpack() {
	if [[ $(declare -p ZIG_VENDOR) == "declare -A"* ]]; then
		local zig_files
		local uri
		for dependency in ${!ZIG_VENDOR[@]}; do
			uri="${ZIG_VENDOR[${dependency}]}"
			zig_files+="${dependency}-${uri##*/}"
		done

		for dist in ${A}; do
			if [[ ${zig_files} =~ ${dist} ]]; then
				ezig fetch "${DISTDIR}/${dist}"
			else
				unpack ${dist}
			fi
		done
	else
		default
	fi
}

# @FUNCTION: zig_src_compile
# @DESCRIPTION:
# This is the zig_src_compile function.
zig_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	local optimize="-Doptimize=ReleaseFast"

	if ver_test "${zig_ver}" -lt "0.11"; then
		optimize="-Drelease-safe"
	fi

	ezig build --verbose ${optimize} ${ezigargs[@]}|| die
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

EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install src_test
