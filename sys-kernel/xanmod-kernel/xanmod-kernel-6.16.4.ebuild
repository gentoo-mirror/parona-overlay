# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Cannot mask for nonsystemd profiles in overlays
#KERNEL_IUSE_GENERIC_UKI=1
KERNEL_IUSE_MODULES_SIGN=1

inherit kernel-build

MY_P=linux-${PV%.*}
PATCHSET=linux-gentoo-patches-6.16.4
GENTOO_CONFIG_VER=g17

XANMOD_VERSION="1"

DESCRIPTION="Linux kernel built with XanMod and Gentoo patches"
HOMEPAGE="https://www.kernel.org/ https://xanmod.org/"
SRC_URI="
	https://cdn.kernel.org/pub/linux/kernel/v$(ver_cut 1).x/${MY_P}.tar.xz
	https://downloads.sourceforge.net/xanmod/patch-${PV}-xanmod${XANMOD_VERSION}.xz
	https://dev.gentoo.org/~mgorny/dist/linux/${PATCHSET}.tar.xz
	https://github.com/mgorny/gentoo-kernel-config/archive/${GENTOO_CONFIG_VER}.tar.gz
		-> gentoo-kernel-config-${GENTOO_CONFIG_VER}.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
KEYWORDS="-* ~amd64"

IUSE="debug"

RDEPEND="
	!sys-kernel/xanmod-kernel-bin:${SLOT}
"
BDEPEND="
	debug? ( dev-util/pahole )
"
PDEPEND="
	>=virtual/dist-kernel-${PV}
"

QA_FLAGS_IGNORED="
	usr/src/linux-.*/scripts/gcc-plugins/.*.so
	usr/src/linux-.*/vmlinux
"

src_prepare() {
	local patch
	eapply "${WORKDIR}"/patch-${PV}-xanmod${XANMOD_VERSION}
	for patch in "${WORKDIR}/${PATCHSET}"/*.patch; do
		eapply "${patch}"
		# non-experimental patches always finish with Gentoo Kconfig
		# when ! use experimental, stop applying after it
		if [[ ${patch} == *Add-Gentoo-Linux-support-config-settings* ]] &&
			true
		then
			break
		fi
	done

	default

	# prepare the default config
	case ${ARCH} in
		amd64)
			cp "${S}/CONFIGS/x86_64/config" .config || die
			;;
		*)
			die "Unsupported arch ${ARCH}"
			;;
	esac

	rm "${S}/localversion" || die
	local myversion="-xanmod${XANMOD_VERSION}-dist"
	echo "CONFIG_LOCALVERSION=\"${myversion}\"" > "${T}"/version.config || die
	local dist_conf_path="${WORKDIR}/gentoo-kernel-config-${GENTOO_CONFIG_VER}"

	local merge_configs=(
		"${T}"/version.config
		"${dist_conf_path}"/base.config
		"${FILESDIR}"/x86-64-v1.config-r1 # keep v1 for simplicity, distribution kernels support user modification.
	)
	use debug || merge_configs+=(
		"${dist_conf_path}"/no-debug.config
	)

	use secureboot && merge_configs+=( "${dist_conf_path}/secureboot.config" )

	kernel-build_merge_configs "${merge_configs[@]}"
}
