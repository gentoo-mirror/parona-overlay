# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	attohttpc@0.26.1
	autocfg@1.2.0
	base64@0.21.7
	bitflags@1.3.2
	bitflags@2.5.0
	block-buffer@0.10.4
	bstr@1.9.1
	bumpalo@3.15.4
	byteorder@1.5.0
	bytes@1.6.0
	bzip2-sys@0.1.11+1.0.8
	bzip2@0.4.4
	camino@1.1.6
	cargo-platform@0.1.8
	cargo_metadata@0.18.1
	cc@1.0.90
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	chrono@0.4.37
	ci_info@0.14.14
	cliparser@0.1.2
	colored@2.1.0
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	cpufeatures@0.2.12
	crc32fast@1.4.0
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crypto-common@0.1.6
	ctrlc@3.4.4
	deranged@0.3.11
	digest@0.10.7
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	dissimilar@1.0.7
	duckscript@0.8.0
	duckscriptsdk@0.9.3
	dunce@1.0.4
	either@1.10.0
	encoding_rs@0.8.33
	envmnt@0.10.4
	equivalent@1.0.1
	errno@0.3.8
	evalexpr@11.3.0
	expect-test@1.5.0
	fastrand@2.0.2
	fern@0.6.2
	fixedbitset@0.4.2
	flate2@1.0.28
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	fs_extra@1.3.0
	fsio@0.4.0
	generic-array@0.14.7
	getrandom@0.2.12
	git_info@0.1.2
	glob@0.3.1
	globset@0.4.14
	hashbrown@0.12.3
	hashbrown@0.14.3
	heck@0.4.1
	hermit-abi@0.3.9
	home@0.5.9
	http@0.2.12
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	idna@0.5.0
	ignore@0.4.22
	indexmap@1.9.3
	indexmap@2.2.6
	itertools@0.12.1
	itoa@1.0.11
	java-properties@2.0.0
	js-sys@0.3.69
	lazy-regex-proc_macros@3.1.0
	lazy-regex@3.1.0
	lazy_static@1.4.0
	lenient_semver@0.4.2
	lenient_semver_parser@0.4.2
	lenient_semver_version_builder@0.4.2
	libc@0.2.153
	libredox@0.1.3
	linux-raw-sys@0.4.13
	log@0.4.21
	memchr@2.7.2
	miniz_oxide@0.7.2
	native-tls@0.2.11
	nix@0.28.0
	nu-ansi-term@0.50.0
	num-conv@0.1.0
	num-traits@0.2.18
	num_cpus@1.16.0
	once_cell@1.19.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-sys@0.9.102
	openssl@0.10.64
	percent-encoding@2.3.1
	petgraph@0.6.4
	pkg-config@0.3.30
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	proc-macro2@1.0.79
	quote@1.0.35
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.4.1
	redox_users@0.4.5
	regex-automata@0.4.6
	regex-syntax@0.8.3
	regex@1.10.4
	ring@0.17.8
	run_script@0.10.1
	rust_info@0.3.2
	rustix@0.38.32
	rustls-webpki@0.101.7
	rustls@0.21.10
	ryu@1.0.17
	same-file@1.0.6
	schannel@0.1.23
	sct@0.7.1
	security-framework-sys@2.10.0
	security-framework@2.10.0
	semver@1.0.22
	serde@1.0.197
	serde_derive@1.0.197
	serde_ignored@0.1.10
	serde_json@1.0.115
	serde_spanned@0.6.5
	sha2@0.10.8
	shell2batch@0.4.5
	spin@0.9.8
	strip-ansi-escapes@0.2.0
	suppaftp@5.3.1
	syn@2.0.58
	tempfile@3.10.1
	thiserror-impl@1.0.58
	thiserror@1.0.58
	time-core@0.1.2
	time@0.3.34
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	toml@0.8.12
	toml_datetime@0.6.5
	toml_edit@0.22.9
	typenum@1.17.0
	uname@0.1.1
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	untrusted@0.9.0
	url@2.5.0
	utf8parse@0.2.1
	vcpkg@0.2.15
	version_check@0.9.4
	vte@0.11.1
	vte_generate_state_changes@0.1.1
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasite@0.1.0
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	web-sys@0.3.69
	webpki-roots@0.25.4
	which@6.0.1
	whoami@1.5.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.4
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.4
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.4
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.4
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.4
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.4
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.4
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.4
	winnow@0.6.5
	winsafe@0.0.19
	zip@0.6.6
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
LICENSE+=" Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-DFS-2016"
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
	"$@" || die -n "Failed to run: $@"
}

src_install() {
	cargo_src_install
	einstalldocs
}
