# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	actix-codec@0.5.2
	actix-cors@0.7.0
	actix-http@3.9.0
	actix-macros@0.2.4
	actix-multipart-derive@0.7.0
	actix-multipart@0.7.2
	actix-router@0.5.3
	actix-rt@2.10.0
	actix-server@2.5.0
	actix-service@2.0.2
	actix-session@0.10.1
	actix-utils@3.0.1
	actix-web-codegen@4.3.0
	actix-web-static-files@4.0.1
	actix-web@4.9.0
	addr2line@0.24.1
	adler2@2.0.0
	adler@1.0.2
	aead@0.5.2
	aes-gcm@0.10.3
	aes@0.8.4
	ahash@0.8.11
	aho-corasick@1.1.3
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	allocator-api2@0.2.18
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.89
	arrayref@0.3.9
	arrayvec@0.7.6
	async-broadcast@0.7.1
	async-channel@2.3.1
	async-io@2.3.4
	async-lock@3.4.0
	async-process@2.3.0
	async-recursion@1.1.1
	async-signal@0.2.10
	async-task@4.7.1
	async-trait@0.1.83
	atomic-waker@1.1.2
	atomic@0.6.0
	autocfg@1.3.0
	backtrace@0.3.74
	base64@0.20.0
	base64@0.22.1
	bitflags@1.3.2
	bitflags@2.6.0
	block-buffer@0.10.4
	blocking@1.6.1
	brotli-decompressor@4.0.1
	brotli@6.0.0
	bumpalo@3.16.0
	bytemuck@1.18.0
	bytemuck_derive@1.7.1
	byteorder-lite@0.1.0
	byteorder@1.5.0
	bytes@1.7.2
	bytestring@1.3.1
	cached@0.53.1
	cached_proc_macro@0.23.0
	cached_proc_macro_types@0.1.1
	cc@1.1.21
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	chrono@0.4.38
	cipher@0.4.4
	clap@4.5.18
	clap_builder@4.5.18
	clap_derive@4.5.18
	clap_lex@0.7.2
	color_quant@1.1.0
	colorchoice@1.0.2
	concurrent-queue@2.5.0
	const_format@0.2.33
	const_format_proc_macros@0.2.33
	convert_case@0.4.0
	cookie@0.16.2
	core-foundation-sys@0.8.7
	cpufeatures@0.2.14
	crc32fast@1.4.2
	crossbeam-channel@0.5.13
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	ctr@0.9.2
	darling@0.20.10
	darling_core@0.20.10
	darling_macro@0.20.10
	deranged@0.3.11
	derive_more-impl@1.0.0
	derive_more@0.99.18
	derive_more@1.0.0
	digest@0.10.7
	either@1.13.0
	encoding_rs@0.8.34
	endi@1.1.0
	enumflags2@0.7.10
	enumflags2_derive@0.7.10
	env_filter@0.1.2
	env_logger@0.11.5
	equivalent@1.0.1
	errno@0.3.9
	event-listener-strategy@0.5.2
	event-listener@5.3.1
	fastrand@2.1.1
	fdeflate@0.3.5
	flate2@1.0.33
	fnv@1.0.7
	fontdue@0.7.3
	form_urlencoded@1.2.1
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-lite@2.3.0
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	futures@0.3.30
	generic-array@0.14.7
	getrandom@0.2.15
	ghash@0.5.1
	gif-dispose@5.0.1
	gif@0.13.1
	gifski@1.32.0
	gimli@0.31.0
	glob@0.3.1
	h2@0.3.26
	hashbrown@0.13.2
	hashbrown@0.14.5
	heck@0.5.0
	hermit-abi@0.3.9
	hermit-abi@0.4.0
	hex@0.4.3
	hkdf@0.12.4
	hmac@0.12.1
	http-auth-basic@0.3.5
	http-body-util@0.1.2
	http-body@1.0.1
	http@0.2.12
	http@1.1.0
	httparse@1.9.4
	httpdate@1.0.3
	humantime@2.1.0
	hyper-util@0.1.9
	hyper@1.4.1
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.61
	ident_case@1.0.1
	idna@0.5.0
	image-webp@0.1.3
	image@0.25.2
	imagequant@4.3.3
	imgref@1.10.1
	impl-more@0.1.6
	indexmap@2.5.0
	inout@0.1.3
	is_terminal_polyfill@1.70.1
	itoa@1.0.11
	jobserver@0.1.32
	jpeg-decoder@0.3.1
	js-sys@0.3.70
	language-tags@0.3.2
	lazy_static@1.5.0
	libc@0.2.159
	libdrm_amdgpu_sys@0.7.5
	libloading@0.8.5
	linux-raw-sys@0.4.14
	local-channel@0.1.5
	local-waker@0.1.4
	lock_api@0.4.12
	log@0.4.22
	loop9@0.1.5
	mach2@0.4.2
	memchr@2.7.4
	memoffset@0.9.1
	miette-derive@7.2.0
	miette@7.2.0
	mime@0.3.17
	mime_guess@2.0.5
	miniz_oxide@0.7.4
	miniz_oxide@0.8.0
	mio@1.0.2
	nix@0.24.3
	nix@0.29.0
	ntapi@0.4.1
	nu-glob@0.98.0
	num-conv@0.1.0
	num-traits@0.2.19
	num_cpus@1.16.0
	object@0.36.4
	once_cell@1.19.0
	opaque-debug@0.3.1
	ordered-channel@1.1.0
	ordered-stream@0.2.0
	parking@2.2.1
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	parse-size@1.1.0
	paste@1.0.15
	path-slash@0.1.5
	pciid-parser@0.7.2
	percent-encoding@2.3.1
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	piper@0.2.4
	pkg-config@0.3.31
	png@0.17.13
	polling@3.7.3
	polyval@0.6.2
	powerfmt@0.2.0
	ppv-lite86@0.2.20
	proc-macro-crate@3.2.0
	proc-macro2@1.0.86
	psutil@3.3.0
	quick-error@2.0.1
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.5.6
	regex-automata@0.4.7
	regex-lite@0.1.6
	regex-syntax@0.8.4
	regex@1.10.6
	resize@0.8.7
	rgb@0.8.50
	ril@0.10.3
	rustc-demangle@0.1.24
	rustc_version@0.4.1
	rustix@0.38.37
	rustversion@1.0.17
	ryu@1.0.18
	scopeguard@1.2.0
	semver@1.0.23
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.128
	serde_plain@1.0.2
	serde_repr@0.1.19
	serde_urlencoded@0.7.1
	sha1@0.10.6
	sha2@0.10.8
	shlex@1.3.0
	signal-hook-registry@1.4.2
	signal-hook@0.3.17
	simd-adler32@0.3.7
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.7
	static-files@0.2.4
	static_assertions@1.1.0
	strict-num@0.1.1
	strsim@0.11.1
	strum@0.26.3
	strum_macros@0.26.4
	subtle@2.6.1
	syn@2.0.77
	sysinfo@0.31.4
	systemd-journal-logger@2.1.1
	tempfile@3.12.0
	test-context-macros@0.3.0
	test-context@0.3.0
	thiserror-impl@1.0.64
	thiserror@1.0.64
	thread_local@1.1.8
	tiff@0.9.1
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tiny-skia-path@0.11.4
	tiny-skia@0.11.4
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	tokio-graceful-shutdown@0.15.1
	tokio-macros@2.4.0
	tokio-util@0.7.12
	tokio@1.40.0
	toml_datetime@0.6.8
	toml_edit@0.22.22
	tower-service@0.3.3
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	try-lock@0.2.5
	ttf-parser@0.15.2
	typenum@1.17.0
	uds_windows@1.1.0
	unicase@2.7.0
	unicode-bidi@0.3.15
	unicode-ident@1.0.13
	unicode-normalization@0.1.24
	unicode-width@0.1.14
	unicode-xid@0.2.6
	universal-hash@0.5.1
	url@2.5.2
	utf8parse@0.2.2
	uuid@1.10.0
	value-bag@1.9.0
	version_check@0.9.5
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.93
	wasm-bindgen-macro-support@0.2.93
	wasm-bindgen-macro@0.2.93
	wasm-bindgen-shared@0.2.93
	wasm-bindgen@0.2.93
	web-time@1.1.0
	weezl@0.1.8
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-core@0.57.0
	windows-implement@0.57.0
	windows-interface@0.57.0
	windows-result@0.1.2
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows@0.57.0
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.6.19
	wrapcenum-derive@0.4.1
	xdg-home@1.3.0
	yata@0.7.0
	zbus@4.4.0
	zbus_macros@4.4.0
	zbus_names@3.0.0
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zstd-safe@7.2.1
	zstd-sys@2.0.13+zstd.1.5.6
	zstd@0.13.2
	zune-core@0.4.12
	zune-jpeg@0.4.13
	zvariant@4.2.0
	zvariant_derive@4.2.0
	zvariant_utils@2.1.0
"

declare -A GIT_CRATES=(
	[nvml-wrapper-sys]='https://github.com/codifryed/nvml-wrapper;6c8426b459e5e52ca39dd5101da78887d49f748d;nvml-wrapper-%commit%/nvml-wrapper-sys'
	[nvml-wrapper]='https://github.com/codifryed/nvml-wrapper;6c8426b459e5e52ca39dd5101da78887d49f748d;nvml-wrapper-%commit%/nvml-wrapper'
)

inherit cargo systemd

DESCRIPTION="Monitor and control your cooling and other devices (daemon)"
HOMEPAGE="https://gitlab.com/coolercontrol/coolercontrol"
SRC_URI="
	https://gitlab.com/coolercontrol/coolercontrol/-/archive/${PV}/coolercontrol-${PV}.tar.bz2
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/coolercontrol-${PV}/${PN}"

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	AGPL-3+ Apache-2.0 BSD-2 BSD GPL-3+ ISC MIT Unicode-DFS-2016 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

IUSE="video_cards_amdgpu"

RDEPEND="
	app-arch/zstd:=
	video_cards_amdgpu? (
		x11-libs/libdrm[video_cards_amdgpu]
	)
"
DEPEND="${RDEPEND}"

QA_FLAGS_IGNORED=".*"

PATCHES=(
	"${FILESDIR}"/coolercontrold-1.4.0-optional-libdrm_amdgpu.patch
)

src_prepare() {
	pushd .. >/dev/null || die
	default
	popd >/dev/null || die

	# Disable stripping
	sed -i -e '/^strip =/d' Cargo.toml || die
}

src_configure() {
	export ZSTD_SYS_USE_PKG_CONFIG=1

	local myfeatures=(
		$(usev video_cards_amdgpu libdrm_amdgpu)
	)

	cargo_src_configure
}

src_install() {
	cargo_src_install

	einstalldocs

	doinitd ../packaging/openrc/init.d/coolercontrol
	doconfd ../packaging/openrc/conf.d/coolercontrol

	systemd_dounit ../packaging/systemd/coolercontrold.service
}

pkg_postinst() {
	if [[ -n ${REPLACING_VERSIONS} ]]; then
		elog "Remember to restart coolercontrol service to use the new version."
	fi
}
