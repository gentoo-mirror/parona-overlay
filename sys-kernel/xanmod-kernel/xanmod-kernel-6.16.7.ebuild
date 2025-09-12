# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Cannot mask for nonsystemd profiles in overlays
#KERNEL_IUSE_GENERIC_UKI=1
KERNEL_IUSE_MODULES_SIGN=1

inherit kernel-build

MY_P=linux-${PV%.*}
PATCHSET=linux-gentoo-patches-6.16.6
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

IUSE="debug modules-compress"

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

	## Taken from the eclass because I have to avoid KERNEL_IUSE_GENERIC_UKI
	# NB: we enable support for compressed modules even with
	# USE=-modules-compress, in order to support both uncompressed and
	# compressed modules in prebuilt kernels.
	cat <<-EOF > "${WORKDIR}/module-compress.config" || die
		CONFIG_MODULE_COMPRESS=y
		CONFIG_MODULE_COMPRESS_XZ=y
	EOF
	# CONFIG_MODULE_COMPRESS_ALL is supported only by >=6.12, for older
	# versions we accomplish the same by overriding suffix-y=
	if use modules-compress; then
		echo "CONFIG_MODULE_COMPRESS_ALL=y" \
			>> "${WORKDIR}/module-compress.config" || die
	else
		echo "# CONFIG_MODULE_COMPRESS_ALL is not set" \
			>> "${WORKDIR}/module-compress.config" || die
	fi
	merge_configs+=( "${WORKDIR}/module-compress.config" )

	kernel-build_merge_configs "${merge_configs[@]}"
}
