# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg

DESCRIPTION="A modding utility for Starfield and some Elder Scrolls and Fallout games."
HOMEPAGE="
	https://loot.github.io/
	https://github.com/loot/loot/
"

VALVEFILEVDF_VER="1.0.1"
TESTING_PLUGINS_VER="1.6.2"

SRC_URI="
	https://github.com/loot/loot/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
	https://github.com/TinyTinni/ValveFileVDF/archive/refs/tags/v${VALVEFILEVDF_VER}.tar.gz
		-> valvefilevdf-${VALVEFILEVDF_VER}.tar.gz
	test? (
		https://github.com/Ortham/testing-plugins/archive/${TESTING_PLUGINS_VER}.tar.gz
			-> testing-plugins-${TESTING_PLUGINS_VER}.tar.gz
	)
"

LICENSE="GPL-3"
SLOT="0"
# keywords not included because im unhappy

IUSE="test"
RESTRICT="!test? ( test )"

# todo: sphinx docs
RDEPEND="
	dev-cpp/libloot:0/$(ver_cut 1-2)
	dev-cpp/ogdf
	dev-cpp/tbb:=
	dev-cpp/tomlplusplus
	dev-cpp/valvefilevdf
	dev-libs/boost:=
	>=dev-libs/icu-71.1:=
	dev-libs/libfmt:=
	dev-libs/spdlog:=
	dev-qt/qtbase:6[concurrent,network,widgets]
	sys-libs/zlib
	sys-libs/minizip-ng:=
"
DEPEND="
	${RDEPEND}
	test? (
		dev-cpp/gtest
	)
"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare

	# minizip-ng package config is broken
	# https://github.com/zlib-ng/minizip-ng/issues/722
	cp "${FILESDIR}"/FindMINIZIP.cmake "${S}"/cmake || die
}

src_configure() {
	local mycmakeargs=(
		-DLOOT_BUILD_TESTS=$(usex test)
		-DGIT_COMMIT_STRING="(Gentoo)" # hijack
		-DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
		-DFETCHCONTENT_TRY_FIND_PACKAGE_MODE=ALWAYS
		-DBoost_USE_STATIC_LIBS=OFF
		-DCMAKE_MODULE_PATH="${S}/cmake"
		# Package config file broken
		-DFETCHCONTENT_SOURCE_DIR_VALVEFILEVDF="${WORKDIR}/ValveFileVDF-${VALVEFILEVDF_VER}"
	)
	use test && mycmakeargs+=(
		-DFETCHCONTENT_SOURCE_DIR_TESTING-PLUGINS="${WORKDIR}/testing-plugins-${TESTING_PLUGINS_VER}"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	for locale in resources/l10n/* ; do
		[[ -e ${locale}/LC_MESSAGES/loot.po ]] || continue
		msgfmt ${locale}/LC_MESSAGES/loot.po -o ${locale}/LC_MESSAGES/loot.mo ||  die
	done
}

src_install() {
	# No installation provided
	# Follows scripts/archive.py somewhat
	dobin "${BUILD_DIR}"/LOOT

	insinto /usr/share/metainfo
	doins resources/linux/io.github.loot.loot.metainfo.xml

	domenu resources/linux/io.github.loot.loot.desktop

	newicon -s scalable resources/icons/loot.svg io.github.loot.loot.svg

	for locale in resources/l10n/* ; do
		[[ -e ${locale}/LC_MESSAGES/loot.mo ]] || continue
		insinto /usr/share/locale/${locale##resources/l10n}/LC_MESSAGES
		doins ${locale}/LC_MESSAGES/loot.mo
	done

	einstalldocs
}
