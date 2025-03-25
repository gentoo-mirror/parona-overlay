# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
inherit cmake desktop python-any-r1 xdg

DESCRIPTION="A modding utility for Starfield and some Elder Scrolls and Fallout games."
HOMEPAGE="
	https://loot.github.io/
	https://github.com/loot/loot/
"

VALVEFILEVDF_VER="1.1.0"
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
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

# todo: sphinx docs
RDEPEND="
	dev-cpp/libloot:0/$(ver_cut 1-2)
	dev-cpp/ogdf
	dev-cpp/tbb:=
	dev-cpp/tomlplusplus
	dev-libs/boost:=
	dev-libs/icu:=
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
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
	')
	sys-devel/gettext
	virtual/pkgconfig
"

python_check_deps() {
	python_has_version "dev-python/sphinx[${PYTHON_USEDEP}]" &&
		python_has_version "dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]"
}

src_prepare() {
	cmake_src_prepare

	# Use Gentoo expected path
	sed -i \
		-e "s|lootDocsPath_ = appPath.parent_path() / \"share\" / \"doc\" / \"loot\";|lootDocsPath_ = appPath.parent_path() / \"share\" / \"doc\" / \"${PF}\" / \"html\" ;|" \
		src/gui/state/loot_paths.cpp || die
	# Change tests to work with this value
	sed -i \
		-e "s|EXPECT_EQ(std::filesystem::u8path(\"prefix\") / \"share\" / \"doc\" / \"loot\",|EXPECT_EQ(std::filesystem::u8path(\"prefix\") / \"share\" / \"doc\" / \"${PF}\" / \"html\",|" \
		src/tests/gui/state/loot_paths_test.h || die

	# Disable update checking by default. Otherwise you have to manually give it a commit.
	sed -i \
		-e 's/bool enableLootUpdateCheck_{true};/bool enableLootUpdateCheck_{false};/' \
		src/gui/state/loot_settings.h || die
	# Change tests to reflect this changed default
	sed -i \
		-e 's/EXPECT_TRUE(settings_.isLootUpdateCheckEnabled());/EXPECT_FALSE(settings_.isLootUpdateCheckEnabled());/' \
		src/tests/gui/state/loot_settings_test.h || die

	# minizip-ng package config is broken
	# https://github.com/zlib-ng/minizip-ng/issues/722
	cp "${FILESDIR}"/FindMINIZIP.cmake "${S}"/cmake || die
}

src_configure() {
	local mycmakeargs=(
		-DLOOT_BUILD_TESTS=$(usex test)
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

	sphinx-build -b html "${S}/docs" "${BUILD_DIR}/docs/html" || die
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

	local HTML_DOCS=( "${BUILD_DIR}"/docs/html/. )
	einstalldocs
}
