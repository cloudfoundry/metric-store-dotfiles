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
  echo_header "Installing ${APP} ${VERSION}"
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
