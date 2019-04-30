DULL=0
BRIGHT=1
FG_RED=31
FG_GREEN=32
FG_YELLOW=33
FG_WHITE=37
BG_NULL=00

##
# ANSI Escape Commands
##
ESC="\033"
RESET="$ESC[${DULL};${FG_WHITE};${BG_NULL}m"
GREEN="$ESC[${DULL};${FG_GREEN}m"
YELLOW="$ESC[${DULL};${FG_YELLOW}m"
BRIGHT_RED="$ESC[${BRIGHT};${FG_RED}m"

echo_red() {
  printf "\n${YELLOW}lc> ${BRIGHT_RED}%b${RESET}" "$1"
}

echo_green() {
  printf "\n${YELLOW}lc> ${GREEN}%b${RESET}" "$1"
}

echo_normal() {
  printf "\n${YELLOW}lc> %b${RESET}" "$1"
}

echo_header() {
  echo_green "${1} ...\n"
}

echo_error() {
  echo_red "... ${1}\n"
}

echo_step() {
  echo_normal "  - ${1}\n"
}

echo_footer() {
  echo_green "... ${1}\n"
}

echo_installing() {
  echo_header "Installing ${APP}"
}

echo_already_installed() {
  echo_error "looks like ${APP} ${VERSION} is already installed, skipping!"
}

echo_installed() {
  echo_footer "${APP} ${VERSION} Installed"
}

within_temp_dir() {
  pushd $HOME/workspace
  mkdir ${APP}
  pushd ${APP}
}

end_temp_dir() {
  popd
  rm -rf ${APP}
  popd
}



# As a developer,
# When I run install.sh
# Then my packages update to latest release version


# As a developer,
# When I run install_on_osx.sh
# Then my packages update to latest release version
# Even if they were installed with brew


identify_package() {
  APP=$1

  which $APP
  status=$?

  if [ $status -ne 0 ]; then
    VERSION=0
  else
    version=`$APP version`

    status=$?
    if [ $status -ne 0 ]; then
      version=`$APP --version`
    fi

    if [ -z "$version" ]; then
      echo "Exiting due to lack of attainable version for $APP"
      exit 2
    fi
  fi

  VERSION=`echo "$version" | egrep -o '([0-9]+\.){2}([0-9]+)'`
  echo_installing
}

identify_os() {
  if [ `uname` = 'Darwin' ]; then
    OS='osx'
  else
    OS='linux'
  fi

  echo "OS=$OS"
}

install_latest_version() {
  set +eux

  github_src=$1 # e.g. cloudfoundry/bosh-bootloader

  latest=`curl -sS https://api.github.com/repos/${github_src}/releases/latest`
  latest_version=`echo "$latest" | awk '/tag_name/ {print $2}' | tr -d \",v`

  if [ "$VERSION" = "$latest_version" ]; then
    echo_already_installed
    exit
  fi

   awk_with_os='/browser_download_url.*'$OS'/ {print $2}'
   latest_download_link=`echo "$latest" | awk "$awk_with_os" | tr -d \"`
   filename=`echo "$latest_download_link" | awk -F / '{print $NF}'`

   wget -q "$latest_download_link"
   status=$?

   if [ $status -ne 0 ]; then
     echo Failed to fetch "$latest_download_link"
     exit 3
   fi

  name="$APP-$latest_version"
  sudo rm -f /usr/local/share/$APP-*
  sudo mv -f $filename /usr/local/share/$name
  sudo chmod +x /usr/local/share/$name
  ln -sf /usr/local/share/$name /usr/local/bin/$APP

  VERSION="$latest_version"

  echo_installed
}

start_install() {
    set -x
}

end_install() {
    set +x
    echo_installed
}
