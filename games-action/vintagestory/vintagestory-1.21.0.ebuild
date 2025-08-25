# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT=8.0
inherit desktop dotnet-pkg-base font xdg

DESCRIPTION="Uncompromising wilderness survival sandbox game (requires paid account)"
HOMEPAGE="https://www.vintagestory.at/"

if [[ ${PV} =~ _rc ]]; then
	MY_PV="${PV/_rc/-rc.}"
	SRC_URI="
		amd64? ( https://cdn.vintagestory.at/gamefiles/unstable/vs_client_linux-x64_${MY_PV}.tar.gz )
	"
else
	SRC_URI="
		amd64? ( https://cdn.vintagestory.at/gamefiles/stable/vs_client_linux-x64_${PV}.tar.gz )
	"
	KEYWORDS="-* ~amd64"
fi
S="${WORKDIR}/${PN}"

LICENSE="all-rights-reserved"
SLOT="0"

REQUIRED_USE="elibc_glibc"
RESTRICT="bindist mirror strip"

# https://wiki.vintagestory.at/index.php?title=Installing_the_game_on_Linux
RDEPEND="
	${DOTNET_PKG_RDEPS}
	media-libs/openal
	virtual/opengl
"
BDEPEND="${DOTNET_PKG_BDEPS}"

QA_PREBUILT="*"
QA_PRESTRIPPED="*"

DESTDIR="/opt/${PN}"

src_prepare() {
	default

	rm install.sh server.sh run.sh || die

	# Fix desktop file for system installed wrappers
	sed -e '/Exec/ s|bash -c "export DOTNET_ROOT=$HOME/.dotnet && ${INST_DIR}/\(.*\)"|\1|' \
		-e '/Exec/ s|bash run.sh|Vintagestory|' \
		-e "s|\${INST_DIR}|${DESTDIR}|" \
		-i *.desktop || die
}

src_install() {
	insinto ${DESTDIR}
	doins -r .

	fperms +x ${DESTDIR}/{Vintagestory,VintagestoryServer,VSCrashReporter}

	dotnet-pkg-base_append-launchervar "mesa_glthread=true"

	dotnet-pkg-base_dolauncher "${DESTDIR}/Vintagestory"
	dotnet-pkg-base_dolauncher "${DESTDIR}/VintagestoryServer"

	domenu Vintagestory.desktop Vintagestory_url_connect.desktop Vintagestory_url_mod.desktop

	FONT_S="${S}/assets/game/fonts" FONT_SUFFIX="ttf" font_src_install

	insinto /usr/lib/sysctl.d
	newins - 60-vintagestory.conf <<-EOF
	# https://wiki.vintagestory.at/Troubleshooting_Guide#Error:_Garbage_collector_could_not_allocate_16384u_bytes_of_memory_for_major_heap_section.
	vm.max_map_count = 262144
	EOF
}
