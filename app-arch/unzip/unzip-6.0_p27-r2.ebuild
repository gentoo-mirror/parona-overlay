# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic multilib toolchain-funcs

MY_PV="${PV//.}"
MY_PV="${MY_PV%_p*}"
MY_P="${PN}${MY_PV}"

DESCRIPTION="unzipper for pkzip-compressed files"
HOMEPAGE="https://infozip.sourceforge.net/UnZip.html"
SRC_URI="https://downloads.sourceforge.net/infozip/${MY_P}.tar.gz
	mirror://debian/pool/main/u/${PN}/${PN}_${PV/_p/-}.debian.tar.xz"

LICENSE="Info-ZIP"
SLOT="0"
IUSE="bzip2 natspec unicode"

DEPEND="bzip2? ( app-arch/bzip2 )
	natspec? ( dev-libs/libnatspec )"
RDEPEND="${DEPEND}"
PDEPEND="app-alternatives/unzip"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${WORKDIR}"/debian/patches
	"${FILESDIR}"/${PN}-6.0-no-exec-stack.patch
	"${FILESDIR}"/${PN}-6.0-format-security.patch
	"${FILESDIR}"/${PN}-6.0-fix-false-overlap-detection-on-32bit-systems.patch
)

src_prepare() {
	# bug #275244
	use natspec && PATCHES+=( "${FILESDIR}"/${PN}-6.0-natspec.patch )

	rm "${WORKDIR}"/debian/patches/02-this-is-debian-unzip.patch || die

	default

	sed -i -r \
		-e '/^CFLAGS/d' \
		-e '/CFLAGS/s:-O[0-9]?:$(CFLAGS) $(CPPFLAGS):' \
		-e '/^STRIP/s:=.*:=true:' \
		-e "s:\<CC *= *\"?g?cc2?\"?\>:CC=\"$(tc-getCC)\":" \
		-e "s:\<LD *= *\"?(g?cc2?|ld)\"?\>:LD=\"$(tc-getCC)\":" \
		-e "s:\<AS *= *\"?(g?cc2?|as)\"?\>:AS=\"$(tc-getCC)\":" \
		-e 's:LF2 = -s:LF2 = :' \
		-e 's:LF = :LF = $(LDFLAGS) :' \
		-e 's:SL = :SL = $(LDFLAGS) :' \
		-e 's:FL = :FL = $(LDFLAGS) :' \
		-e "/^#L_BZ2/s:^$(use bzip2 && echo .)::" \
		-e 's:$(AS) :$(AS) $(ASFLAGS) :g' \
		unix/Makefile \
		|| die "sed unix/Makefile failed"

	# Delete bundled code to make sure we don't use it.
	rm -r bzip2 || die
}

src_configure() {
	case ${CHOST} in
		i?86*-*linux*)       TARGET="linux_asm" ;;
		*linux*)             TARGET="linux_noasm" ;;
		*-darwin*)           TARGET="macosx" ;;
		*-solaris*)          TARGET="generic" ;;
		*) die "Unknown target; please update the ebuild to handle ${CHOST}" ;;
	esac

	# Needed for Clang 16
	append-flags -std=gnu89

	[[ ${CHOST} == *linux* ]] && append-cppflags -DNO_LCHMOD
	use bzip2 && append-cppflags -DUSE_BZIP2
	use unicode && append-cppflags -DUNICODE_SUPPORT -DUNICODE_WCHAR -DUTF8_MAYBE_NATIVE -DUSE_ICONV_MAPPING

	# bug #281473
	append-cppflags -DLARGE_FILE_SUPPORT
}

src_compile() {
	ASFLAGS="${ASFLAGS} $(get_abi_CFLAGS)" emake -f unix/Makefile ${TARGET}
}

src_install() {
	dobin funzip unzipsfx unix/zipgrep
	newbin unzip info-unzip
	dosym info-unzip /usr/bin/zipinfo
	doman man/{funzip,unzipsfx,zipgrep,zipinfo}.1
	newman man/unzip.1 info-unzip.1
	dodoc BUGS History* README ToDo WHERE
}
