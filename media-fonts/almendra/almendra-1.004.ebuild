# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="cbfb186e46e3f44ae1e4f70490becbcc5386e0de"

inherit font

DESCRIPTION="Almendra is a typeface design based on calligraphy"
HOMEPAGE="https://github.com/google/fonts"
SRC_URI="
	https://github.com/google/fonts/blob/${COMMIT}/ofl/almendra/Almendra-Bold.ttf
		-> Almendra-Bold-${COMMIT}.ttf
	https://github.com/google/fonts/blob/${COMMIT}/ofl/almendra/Almendra-BoldItalic.ttf
		-> Almendra-BoldItalic-${COMMIT}.ttf
	https://github.com/google/fonts/blob/${COMMIT}/ofl/almendra/Almendra-Italic.ttf
		-> Almendra-Italic-${COMMIT}.ttf
	https://github.com/google/fonts/blob/${COMMIT}/ofl/almendra/Almendra-Regular.ttf
		-> Almendra-Regular-${COMMIT}.ttf
	https://github.com/google/fonts/blob/${COMMIT}/ofl/almendra/DESCRIPTION.en_us.html
		-> ${PN}-${COMMIT}-DESCRIPTION.en_us.html
	https://github.com/google/fonts/blob/${COMMIT}/ofl/almendra/FONTLOG.txt
		-> ${PN}-${COMMIT}-FONTLOG.txt
	https://github.com/google/fonts/blob/${COMMIT}/ofl/almendra/METADATA.pb
		-> ${PN}-${COMMIT}-METADATA.pb
"

S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

FONT_SUFFIX="ttf"

DOCS=( DESCRIPTION.en_us.html FONTLOG.txt METADATA.pb )

src_unpack() {
	for type in Bold BoldItalic Italic Regular; do
		cp "${DISTDIR}"/Almendra-${type}-${COMMIT}.ttf Almendra-${type}.ttf || die
	done
	for file in DESCRIPTION.en_us.html FONTLOG.txt METADATA.pb; do
		cp "${DISTDIR}"/${PN}-${COMMIT}-${file} ${file} || die
	done
}
