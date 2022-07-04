# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The Hare programming language"
HOMEPAGE="https://sr.ht/~sircmpwn/hare/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/hare"
else
	COMMIT="1682bebc05108932a716487458ba23e95472731c" # 2022-06-23
	SRC_URI="https://git.sr.ht/~sircmpwn/hare/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="MPL-2.0"
SLOT="0"

RDEPEND="
	dev-lang/harec
"
BDEPEND="
	app-text/scdoc
	dev-lang/harec
	sys-devel/qbe
"

src_prepare() {
	eapply_user
	cat <<-EOF > config.mk
PREFIX = ${EPREFIX}/usr
BINDIR = \$(PREFIX)/bin
MANDIR = \$(PREFIX)/share/man
SRCDIR = \$(PREFIX)/src

# Where to install the stdlib tree
STDLIB = \$(SRCDIR)/hare/stdlib

# Default HAREPATH
LOCALSRCDIR = ${EPREFIX}/usr/src/hare
HAREPATH = \$(LOCALSRCDIR)/stdlib:\$(LOCALSRCDIR)/third-party:\$(SRCDIR)/hare/stdlib:\$(SRCDIR)/hare/third-party

## Build configuration

# Platform to build for
PLATFORM = linux
ARCH = x86_64

# External tools and flags
HAREC = harec
HAREFLAGS =
QBE = qbe
AS = as
LD = ld
AR = ar
SCDOC = scdoc

# Where to store build artifacts
HARECACHE = .cache
BINOUT = .bin

# Cross-compiler toolchains
AARCH64_AS=aarch64-as
AARCH64_AR=aarch64-ar
AARCH64_CC=aarch64-cc
AARCH64_LD=aarch64-ld

RISCV64_AS=riscv64-as
RISCV64_AR=riscv64-ar
RISCV64_CC=riscv64-cc
RISCV64_LD=riscv64-ld

X86_64_AS=as
X86_64_AR=ar
X86_64_CC=cc
X86_64_LD=ld
	EOF
}

# -j1 due to race conditions in the build system

src_compile() {
	emake -j1
}

src_test() {
	# Math stuff fails
	emake -j1 check
}
