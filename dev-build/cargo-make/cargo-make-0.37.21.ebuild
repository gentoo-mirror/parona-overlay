# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.0
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	arbitrary@1.3.2
	attohttpc@0.28.0
	autocfg@1.4.0
	base64@0.22.1
	bitflags@2.6.0
	block-buffer@0.10.4
	bstr@1.10.0
	bumpalo@3.16.0
	byteorder@1.5.0
	bytes@1.7.2
	bzip2-sys@0.1.11+1.0.8
	bzip2@0.4.4
	camino@1.1.9
	cargo-platform@0.1.8
	cargo_metadata@0.18.1
	cc@1.1.24
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	chrono@0.4.38
	ci_info@0.14.14
	cliparser@0.1.2
	colored@2.1.0
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	cpufeatures@0.2.14
	crc32fast@1.4.2
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	ctrlc@3.4.5
	deranged@0.3.11
	derive_arbitrary@1.3.2
	digest@0.10.7
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	displaydoc@0.2.5
	dissimilar@1.0.9
	duckscript@0.10.0
	duckscriptsdk@0.11.0
	dunce@1.0.5
	either@1.13.0
	encoding_rs@0.8.34
	envmnt@0.10.4
	equivalent@1.0.1
	errno@0.3.9
	evalexpr@11.3.0
	expect-test@1.5.0
	fastrand@2.1.1
	fern@0.6.2
	fixedbitset@0.4.2
	flate2@1.0.34
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	fs_extra@1.3.0
	fsio@0.4.0
	futures-core@0.3.30
	futures-io@0.3.30
	futures-lite@2.3.0
	generic-array@0.14.7
	getrandom@0.2.15
	git_info@0.1.3
	glob@0.3.1
	globset@0.4.15
	hashbrown@0.12.3
	hashbrown@0.15.0
	heck@0.5.0
	hermit-abi@0.3.9
	home@0.5.9
	http@1.1.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.61
	idna@0.5.0
	ignore@0.4.23
	indexmap@1.9.3
	indexmap@2.6.0
	itertools@0.13.0
	itoa@1.0.11
	java-properties@2.0.0
	js-sys@0.3.70
	lazy-regex-proc_macros@3.3.0
	lazy-regex@3.3.0
	lazy_static@1.5.0
	lenient_semver@0.4.2
	lenient_semver_parser@0.4.2
	lenient_semver_version_builder@0.4.2
	libc@0.2.159
	libredox@0.1.3
	linux-raw-sys@0.4.14
	lockfree-object-pool@0.1.6
	log@0.4.22
	md5@0.7.0
	memchr@2.7.4
	miniz_oxide@0.8.0
	native-tls@0.2.12
	nix@0.29.0
	nu-ansi-term@0.50.1
	num-conv@0.1.0
	num-traits@0.2.19
	num_cpus@1.16.0
	once_cell@1.20.1
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-sys@0.9.103
	openssl@0.10.66
	parking@2.2.1
	percent-encoding@2.3.1
	petgraph@0.6.5
	pin-project-lite@0.2.14
	pkg-config@0.3.31
	portable-atomic@1.9.0
	powerfmt@0.2.0
	ppv-lite86@0.2.20
	proc-macro2@1.0.86
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.5.7
	redox_users@0.4.6
	regex-automata@0.4.8
	regex-syntax@0.8.5
	regex@1.11.0
	ring@0.17.8
	run_script@0.11.0
	rust_info@0.3.3
	rustix@0.38.37
	rustls-pki-types@1.9.0
	rustls-webpki@0.102.8
	rustls@0.22.4
	rustversion@1.0.17
	ryu@1.0.18
	same-file@1.0.6
	schannel@0.1.24
	security-framework-sys@2.12.0
	security-framework@2.11.1
	semver@1.0.23
	serde@1.0.210
	serde_derive@1.0.210
	serde_ignored@0.1.10
	serde_json@1.0.128
	serde_spanned@0.6.8
	sha2@0.10.8
	shell2batch@0.4.5
	shlex@1.3.0
	simd-adler32@0.3.7
	spin@0.9.8
	strip-ansi-escapes@0.2.0
	strum_macros@0.26.4
	subtle@2.6.1
	suppaftp@6.0.1
	syn@2.0.79
	tempfile@3.13.0
	thiserror-impl@1.0.64
	thiserror@1.0.64
	time-core@0.1.2
	time@0.3.36
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.22
	typenum@1.17.0
	uname@0.1.1
	unicode-bidi@0.3.17
	unicode-ident@1.0.13
	unicode-normalization@0.1.24
	untrusted@0.9.0
	url@2.5.2
	utf8parse@0.2.2
	vcpkg@0.2.15
	version_check@0.9.5
	vte@0.11.1
	vte_generate_state_changes@0.1.2
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasite@0.1.0
	wasm-bindgen-backend@0.2.93
	wasm-bindgen-macro-support@0.2.93
	wasm-bindgen-macro@0.2.93
	wasm-bindgen-shared@0.2.93
	wasm-bindgen@0.2.93
	web-sys@0.3.70
	webpki-roots@0.26.6
	which@6.0.3
	whoami@1.5.2
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.6.20
	winsafe@0.0.19
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zeroize@1.8.1
	zip@2.2.0
	zopfli@0.8.1
"

inherit cargo

DESCRIPTION="Rust task runner and build tool"
HOMEPAGE="https://sagiegurari.github.io/cargo-make"
SRC_URI="
	https://github.com/sagiegurari/cargo-make/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD Boost-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
IUSE="openssl +rustls test"
REQUIRED_USE="?? ( openssl rustls )"

RESTRICT="!test? ( test )"

DEPEND="
	openssl? ( dev-libs/openssl:= )
"
RDEPEND="
	!dev-util/cargo-make
	${DEPEND}
"
BDEPEND="
	test? ( dev-build/cargo-make )
"

QA_FLAGS_IGNORED=".*"

src_configure() {
	local myfeatures=(
		$(usev openssl tls-native)
		$(usev rustls tls-rustls)
	)
	cargo_src_configure --no-default-features
}

src_test() {
	local CARGO_SKIP=(
		# Test checks that S directory name matches PN. This fails as expected.
		# assertion `left == right` failed
		# left: "cargo-make-0.37.10"
		# right: "cargo-make"
		environment::mod_test::get_base_directory_name_valid
		# Not a git repo
		# assertion failed: output.is_empty()
		io::io_test::get_path_list_dirs_with_gitignore
		# Requires working rustup https://bugs.gentoo.org/834741
		# Failed to check rustup toolchain: Os { code: 2, kind: NotFound, message: "No such file or directory" }
		installer::crate_installer::crate_installer_test::install_test_with_toolchain_test
		installer::crate_installer::crate_installer_test::invoke_cargo_install_with_toolchain_test
		installer::rustup_component_installer::rustup_component_installer_test::install_with_toolchain_test
		installer::rustup_component_installer::rustup_component_installer_test::is_installed_with_toolchain_non_zero
		toolchain::toolchain_test::get_cargo_binary_path_valid
		toolchain::toolchain_test::wrap_command_empty_args
		toolchain::toolchain_test::wrap_command_none_args
		toolchain::toolchain_test::wrap_command_with_args
		toolchain::toolchain_test::wrap_command_with_args_and_simple_variable_toolchain
		# assertion failed: version.is_some()
		installer::crate_version_check::crate_version_check_test::get_crate_version_for_rustup_component
		# Tries to install crates so most likely a network issue
		# test error flow: Error while executing command, exit code: 101
		installer::cargo_plugin_installer::cargo_plugin_installer_test::install_crate_already_installed_cargo_make_without_check
		installer::crate_installer::crate_installer_test::install_already_installed_crate_only_min_version_equal
		installer::crate_installer::crate_installer_test::install_already_installed_crate_only_min_version_smaller
		installer::crate_installer::crate_installer_test::install_already_installed_crate_only_version_equal
		# Checks crate versions
		# assertion failed: !valid
		installer::crate_version_check::crate_version_check_test::is_min_version_valid_newer_version
		installer::crate_version_check::crate_version_check_test::is_version_valid_newer_version
		installer::crate_version_check::crate_version_check_test::is_version_valid_old_version
		# called `Option::unwrap()` on a `None` value
		installer::crate_version_check::crate_version_check_test::is_min_version_valid_same_version
		installer::crate_version_check::crate_version_check_test::is_version_valid_same_version

		# test error flow: Unable to execute rust code.
		scriptengine::mod_test::invoke_rust_runner
		# assertion failed: enabled
		condition::condition_test::validate_files_modified_input_newer
	)

	# https://github.com/sagiegurari/cargo-make/issues/573#issuecomment-886147300
	set -- cargo make --env CARGO_MAKE_CARGO_BUILD_TEST_FLAGS="-- ${CARGO_SKIP[*]/#/--skip }" test
	einfo "$@"
	cargo_env "$@" || die -n "Failed to run: $@"
}

src_install() {
	cargo_src_install
	einstalldocs
}
