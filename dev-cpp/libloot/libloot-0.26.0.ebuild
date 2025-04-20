# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# manual process to get all three rust packages
CRATES="
	adler2@2.0.0
	aho-corasick@1.1.3
	anes@0.1.6
	anstyle@1.0.10
	anstyle@1.0.7
	autocfg@1.2.0
	autocfg@1.4.0
	bitflags@2.5.0
	bitflags@2.9.0
	block-buffer@0.10.4
	bumpalo@3.16.0
	bumpalo@3.17.0
	cast@0.3.0
	cfg-if@1.0.0
	ciborium-io@0.2.2
	ciborium-ll@0.2.2
	ciborium@0.2.2
	clap@4.5.37
	clap@4.5.4
	clap_builder@4.5.2
	clap_builder@4.5.37
	clap_lex@0.7.0
	clap_lex@0.7.4
	const-random-macro@0.1.16
	const-random@0.1.18
	cpufeatures@0.2.12
	crc32fast@1.4.2
	criterion-plot@0.5.0
	criterion@0.5.1
	crossbeam-deque@0.8.5
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crossbeam-utils@0.8.21
	crunchy@0.2.2
	crunchy@0.2.3
	crypto-common@0.1.6
	dataview@1.0.1
	derive_pod@0.1.2
	digest@0.10.7
	dirs-sys@0.5.0
	dirs@6.0.0
	dlv-list@0.5.2
	either@1.11.0
	either@1.15.0
	encoding_rs@0.8.34
	encoding_rs@0.8.35
	errno@0.3.10
	errno@0.3.11
	esplugin@6.1.1
	fastrand@2.1.1
	fastrand@2.3.0
	flate2@1.1.1
	generic-array@0.14.7
	getrandom@0.2.14
	getrandom@0.3.1
	getrandom@0.3.2
	half@2.4.1
	half@2.6.0
	hashbrown@0.14.5
	hermit-abi@0.3.9
	hermit-abi@0.5.0
	is-terminal@0.4.12
	is-terminal@0.4.16
	itertools@0.10.5
	itoa@1.0.11
	itoa@1.0.15
	js-sys@0.3.69
	js-sys@0.3.77
	keyvalues-parser@0.2.0
	libc@0.2.171
	libc@0.2.172
	libredox@0.1.3
	linux-raw-sys@0.9.2
	linux-raw-sys@0.9.4
	log@0.4.21
	log@0.4.27
	memchr@2.7.4
	minimal-lexical@0.2.1
	miniz_oxide@0.8.8
	no-std-compat@0.4.1
	nom@7.1.3
	nom@8.0.0
	num-traits@0.2.18
	num-traits@0.2.19
	once_cell@1.19.0
	once_cell@1.21.3
	oorandom@11.1.3
	oorandom@11.1.5
	option-ext@0.2.0
	ordered-multimap@0.7.3
	pelite-macros@0.1.1
	pelite@0.10.0
	pest@2.7.10
	pest_derive@2.7.10
	pest_generator@2.7.10
	pest_meta@2.7.10
	plotters-backend@0.3.5
	plotters-backend@0.3.7
	plotters-svg@0.3.5
	plotters-svg@0.3.7
	plotters@0.3.5
	plotters@0.3.7
	proc-macro2@1.0.81
	proc-macro2@1.0.93
	proc-macro2@1.0.95
	quote@1.0.36
	quote@1.0.40
	r-efi@5.2.0
	rayon-core@1.12.1
	rayon@1.10.0
	redox_users@0.5.0
	regex-automata@0.4.8
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rust-ini@0.21.1
	rustix@1.0.0
	rustix@1.0.1
	rustix@1.0.5
	rustversion@1.0.20
	ryu@1.0.17
	ryu@1.0.20
	same-file@1.0.6
	serde@1.0.200
	serde@1.0.219
	serde_derive@1.0.200
	serde_derive@1.0.219
	serde_json@1.0.116
	serde_json@1.0.140
	sha2@0.10.8
	syn@2.0.100
	syn@2.0.60
	syn@2.0.96
	tempfile@3.19.1
	thiserror-impl@1.0.59
	thiserror-impl@2.0.11
	thiserror@1.0.59
	thiserror@2.0.11
	tiny-keccak@2.0.2
	tinytemplate@1.2.1
	trim-in-place@0.1.7
	typenum@1.17.0
	ucd-trie@0.1.6
	unicase@2.8.1
	unicode-ident@1.0.12
	unicode-ident@1.0.18
	version_check@0.9.4
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasi@0.13.3+wasi-0.2.2
	wasi@0.14.2+wasi-0.2.4
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.100
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.100
	wasm-bindgen@0.2.92
	web-sys@0.3.69
	web-sys@0.3.77
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-collections@0.2.0
	windows-core@0.61.0
	windows-future@0.2.0
	windows-implement@0.60.0
	windows-interface@0.59.1
	windows-link@0.1.1
	windows-numerics@0.2.0
	windows-result@0.3.2
	windows-strings@0.4.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows@0.61.1
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	wit-bindgen-rt@0.33.0
	wit-bindgen-rt@0.39.0
"

inherit cargo cmake rust-toolchain

DESCRIPTION="A C++ library for accessing LOOT's metadata and sorting functionality."
HOMEPAGE="
	https://loot.github.io/
	https://github.com/loot/libloot/
"

declare -A VENDORED_PACKAGE=(
	[esplugin]="https://github.com/Ortham/esplugin/archive/refs/tags/6.1.2.tar.gz"
	[libloadorder]="https://github.com/Ortham/libloadorder/archive/refs/tags/18.3.0.tar.gz"
	[loot-condition-interpeter]="https://github.com/loot/loot-condition-interpreter/archive/refs/tags/5.3.0.tar.gz"
)
TESTING_PLUGINS_VER="1.6.2"
YAML_CPP_VER="0.8.0+merge-key-support.3"

SRC_URI="
	https://github.com/loot/libloot/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
	https://github.com/loot/yaml-cpp/archive/${YAML_CPP_VER}.tar.gz
		-> loot-yaml-cpp-${YAML_CPP_VER}.tar.gz
	test? (
		https://github.com/Ortham/testing-plugins/archive/${TESTING_PLUGINS_VER}.tar.gz
			-> testing-plugins-${TESTING_PLUGINS_VER}.tar.gz
	)
	${CARGO_CRATE_URIS}
"

vendor_uris() {
	for dependency in ${!VENDORED_PACKAGE[@]}; do
		uri="${VENDORED_PACKAGE[${dependency}]}"
		SRC_URI+=" ${uri} -> ${dependency}-${uri##*/}"
	done
}
vendor_uris

LICENSE="GPL-3"
# testing-plugins, yaml-cpp
LICENSE+=" MIT"
# esplugin
LICENSE+=" Apache-2.0 BSD CC0-1.0 GPL-3 MIT MPL-2.0 Unicode-3.0 Unicode-DFS-2016"
# loot-condition-interpeter
LICENSE+=" Apache-2.0 BSD GPL-3 MIT Unicode-DFS-2016"
# libloadorder
LICENSE+=" Apache-2.0 BSD CC0-1.0 GPL-3 MIT MPL-2.0 Unicode-DFS-2016"

SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/tbb:=
	dev-libs/boost
	dev-libs/icu:=
	dev-libs/libfmt:=
	dev-libs/spdlog:=
"
DEPEND="
	${RDEPEND}
	test? (
		dev-cpp/gtest
	)
"
BDEPEND="
	dev-util/cbindgen
"

CMAKE_SKIP_TESTS=(
	# Requires Turkish and Greek locales
	"CompareFilenames.shouldBeCaseInsensitiveAndLocaleInvariant"
	# Requires Greek locale
	"NormalizeFilename.shouldCaseFoldStringsAndBeLocaleInvariant"
)

src_prepare() {
	cmake_src_prepare

	if use debug; then
		# hookup cargo debug
		sed -i -e "s|--release||" -e "s|/release|/debug|g" CMakeLists.txt || die
	fi
	sed -i -e 's/set(RUST_TARGET_ARGS \(.*\))/set(RUST_TARGET_ARGS \1 ${RUST_TARGET_ARGS})/' CMakeLists.txt || die
}

src_configure() {
	cargo_src_configure

	local mycmakeargs=(
		-DLIBLOOT_BUILD_TESTS=$(usex test)
		-DLIBLOOT_INSTALL_DOCS=OFF # todo
		-DGIT_COMMIT_STRING="(Gentoo)" # hijack
		-DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
		-DRUST_TARGET=$(rust_abi)
		-DRUST_TARGET_ARGS="${ECARGO_ARGS}"
		-DFETCHCONTENT_TRY_FIND_PACKAGE_MODE=ALWAYS
		# https://github.com/jbeder/yaml-cpp/pull/1279
		-DFETCHCONTENT_SOURCE_DIR_YAML-CPP="${WORKDIR}/yaml-cpp-${YAML_CPP_VER/+/-}" # forked
	)
	use test && mycmakeargs+=(
		-DFETCHCONTENT_SOURCE_DIR_TESTING-PLUGINS="${WORKDIR}/testing-plugins-${TESTING_PLUGINS_VER}"
	)
	cargo_env cmake_src_configure

	for dependency in ${!VENDORED_PACKAGE[@]}; do
		uri="${VENDORED_PACKAGE[${dependency}]}"
		filename="${uri##*/}"
		cp "${DISTDIR}/${dependency}-${filename}" "${BUILD_DIR}/external/src/${filename}" || die
	done
}

src_compile() {
	cargo_env cmake_src_compile
}
