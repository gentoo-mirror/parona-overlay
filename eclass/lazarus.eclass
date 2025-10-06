# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#TODO: ability to give flags to FPC by the user?

# @ECLASS: lazarus.eclass
# @MAINTAINER:
# Alfred Wingate <parona@protonmail.com>
# @AUTHOR:
# Alfred Wingate <parona@protonmail.com>
# @SUPPORTED_EAPIS: 8
# @BLURB: common ebuild function for lazarus-based ebuilds

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_LAZARUS_ECLASS} ]]; then
_LAZARUS_ECLASS=1

inherit multiprocessing

# @ECLASS_VARIABLE: LAZARUS_WIDGET
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Set the project wiget. Adds the option --widgetset and required dependencies if set.
# Supported values: gtk2 gtk3 qt6

if [[ -n ${LAZARUS_WIDGET} ]]; then
	case ${LAZARUS_WIDGET} in
		gtk2)
			RDEPEND="x11-libs/gtk+:2="
			DEPEND="x11-libs/gtk+:2="
			BDEPEND="dev-lang/lazarus[gtk2(-)]"
			;;
		gtk3)
			RDEPEND="x11-libs/gtk+:3="
			DEPEND="x11-libs/gtk+:3="
			BDEPEND="dev-lang/lazarus[gtk(-)]"
			;;
		qt6)
			RDEPEND="dev-libs/libqt6pas:="
			DEPEND="dev-libs/libqt6pas:="
			BDEPEND="dev-lang/lazarus[qt6(-)]"
			;;
		*)
			die "Unknown LAZARUS_WIDGET value: ${LAZARUS_WIDGET}"
			;;
	esac
fi

# @ECLASS_VARIABLE: MY_LAZARUSBUILDOPTS
# @USER_VARIABLE
# @DESCRIPTION:
# User-controlled environment variable containing arguments to be passed to lazbuild.

# @FUNCTION: elazbuild
# @USAGE: [<args>...]
# @DESCRIPTION:
# Call lazbuild with default arguments in addition to supplied arguments.
elazbuild() {
	local _lazarusbuildopts=(
		--max-process-count=$(get_makeopts_jobs)
		--verbose
		--lazarusdir=/usr/share/lazarus/
		--primary-config-path="${T}"/lazconfig
		${LAZARUS_WIDGET:+--widgetset=${LAZARUS_WIDGET}}
		${MY_LAZARUSBUILDOPTS}
	)

	set -- lazbuild ${_lazarusbuildopts[@]} ${@}
	einfo "${@}"
	"${@}" || die
}

fi
