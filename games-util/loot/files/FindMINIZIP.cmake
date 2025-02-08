find_package(PkgConfig REQUIRED)

pkg_check_modules(MINIZIP IMPORTED_TARGET minizip-ng)

add_library(MINIZIP::minizip ALIAS PkgConfig::MINIZIP)
