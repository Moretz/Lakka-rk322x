PKG_NAME="cap32"
PKG_VERSION="main"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/Moretz/libretro-cap32"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="caprice32 4.2.0 libretro"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v cap32_libretro.so ${INSTALL}/usr/lib/libretro/
}
