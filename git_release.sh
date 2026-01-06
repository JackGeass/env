#!/usr/bin/env bash

#PROJECT_NAME="helm"
#TILLER_NAME="tiller"

#RELEASE_URL='https://github.com/neovim/neovim/releases/'
#DOWNLOAD_FROMAT='echo $RELEASE_URL/download/$TAG/nvim-$OS$ARCH_BITS.tar.gz'


: ${USE_SUDO:="true"}
: ${HELM_INSTALL_DIR:="/usr/local/bin"}

# initArch discovers the architecture for this system.
initArch() {
  ARCH=$(uname -m)
  case $ARCH in
    armv5*) ARCH="armv5";;
    armv6*) ARCH="armv6";;
    armv7*) ARCH="arm";;
    aarch64) ARCH="arm64";;
    x86) ARCH="386";;
    x86_64) ARCH="amd64";;
    i686) ARCH="386";;
    i386) ARCH="386";;
  esac
}

initArchBits() {
  _ARCH=$(uname -m)
  case $_ARCH in
    armv5*) ARCH_BITS="32";;
    armv6*) ARCH_BITS="32";;
    armv7*) ARCH_BITS="32";;
    aarch64) ARCH_BITS="64";;
    x86) ARCH_BITS="32";;
    x86_64) ARCH_BITS="64";;
    i686) ARCH_BITS="32";;
    i386) ARCH_BITS="32";;
  esac
}

# initOS discovers the operating system for this system.
initOS() {
  OS=$(echo `uname`|tr '[:upper:]' '[:lower:]')

  case "$OS" in
    # Minimalist GNU for Windows
    mingw*) OS='windows';;
  esac
}

# checkDesiredVersion checks if the desired version is available.
checkDesiredVersion() {
  if [ "x$DESIRED_VERSION" == "x" ]; then
    # Get tag from release URL
    local latest_release_url=$RELEASE_URL/latest
    if type "curl" > /dev/null; then
      TAG=$(curl -Ls -o /dev/null -w %{url_effective} $latest_release_url | grep -oE "[^/]+$" )
    elif type "wget" > /dev/null; then
      TAG=$(wget $latest_release_url --server-response -O /dev/null 2>&1 | awk '/^  Location: /{DEST=$2} END{ print DEST}' | grep -oE "[^/]+$")
    fi
  else
    TAG=$DESIRED_VERSION
  fi
}

# runs the given command as root (detects if we are root already)
#runAsRoot() {
#  local CMD="$*"
#
#  if [ $EUID -ne 0 -a $USE_SUDO = "true" ]; then
#    CMD="sudo $CMD"
#  fi
#
#  $CMD
#}
initArch
initArchBits
initOS
checkDesiredVersion
#echo $ARCH
#echo $OS
#echo $TAG
#echo $ARCH_BITS
echo $(eval echo $FROMAT)
#echo https://github.com/neovim/neovim/releases/download/v0.3.8/nvim-linux64.tar.gz
#wget $RELEASE_URL/download/$TAG/nvim-$OS$ARCH_BITS.tar.gz
