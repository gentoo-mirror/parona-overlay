# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature xdg-utils virtualx

DESCRIPTION="Cross-platform Clipboard module for Python with binary support."
HOMEPAGE="
	https://pypi.org/project/pyclip/
	https://github.com/spyoungtech/pyclip
"
SRC_URI="
	https://github.com/spyoungtech/pyclip/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# wayland cannot be tested for now
# dev-libs/weston[headless]
# gui-apps/wl-clipboard
BDEPEND="
	test? (
		x11-misc/xclip
	)
"

PATCHES=(
	"${FILESDIR}"/pyclip-0.7.0-dont-run-xclip-tests-on-wayland.patch
)

distutils_enable_tests pytest

python_test() {
	xdg_environment_reset

	# Run first with X
	einfo "Running tests against Xorg"
	unset WAYLAND_DISPLAY
	virtx epytest

	# TODO: https://gitlab.freedesktop.org/wayland/weston/-/issues/294
	# # Then with wayland
	# einfo "Running tests against Wayland"
	# export XDG_RUNTIME_DIR="$(mktemp -p $(pwd) -d xdg-runtime-XXXXXX)"
	# weston --backend=drm-backend.so --socket=wayland-5 --idle-time=0 &
	# compositor=$!
	# export WAYLAND_DISPLAY=wayland-5
	# nonfatal epytest
	# exit_code=$?
	# kill ${compositor}
	# [[ $exit_code != 0 ]] && die
}

pkg_postinst() {
	optfeature "Xorg clipboard support" x11-misc/xclip
	optfeature "Wayland clipboard support" gui-apps/wl-clipboard
}
