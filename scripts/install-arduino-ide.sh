#!/bin/sh

set -eu

readonly RELEASES_URL="https://github.com/arduino/arduino-ide/releases/latest"
readonly DOWNLOAD_BASE_URL="https://downloads.arduino.cc/arduino-ide"

version="${ARDUINO_IDE_VERSION:-}"
dry_run=false

usage() {
  cat <<'EOF'
Usage: install-arduino-ide.sh [--version VERSION] [--dry-run]

Download the official Arduino IDE for Linux, install it under
~/Applications, and create an arduino-ide command in ~/.local/bin.

Options:
  --version VERSION  Install a specific version instead of the latest release
  --dry-run          Print the planned paths and URL without changing anything
  -h, --help         Show this help

Environment:
  ARDUINO_IDE_VERSION       Alternative way to specify the version
  ARDUINO_IDE_INSTALL_ROOT  Installation root (default: ~/Applications)
  ARDUINO_IDE_BIN_DIR       Command directory (default: ~/.local/bin)
EOF
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "required command not found: $1"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --version)
      [ "$#" -ge 2 ] || die "--version requires a value"
      version=$2
      shift 2
      ;;
    --dry-run)
      dry_run=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "unknown option: $1"
      ;;
  esac
done

[ "$(uname -s)" = "Linux" ] || die "this script supports Linux only"

case "$(uname -m)" in
  x86_64|amd64) ;;
  *) die "Arduino IDE 2 is distributed for Linux x86-64; this CPU is $(uname -m)" ;;
esac

require_command curl

if [ -z "$version" ]; then
  printf 'Finding the latest Arduino IDE release...\n'
  latest_url=$(curl --fail --silent --show-error --location \
    --output /dev/null --write-out '%{url_effective}' "$RELEASES_URL")
  version=${latest_url##*/}
fi

version=${version#v}
case "$version" in
  ''|*[!0-9.]*|.*|*.|*..*) die "invalid version: $version" ;;
esac

install_root=${ARDUINO_IDE_INSTALL_ROOT:-"$HOME/Applications"}
bin_dir=${ARDUINO_IDE_BIN_DIR:-"$HOME/.local/bin"}
install_dir="$install_root/arduino-ide-$version"
stable_link="$install_root/arduino-ide"
command_link="$bin_dir/arduino-ide"
archive_name="arduino-ide_${version}_Linux_64bit.zip"
download_url="$DOWNLOAD_BASE_URL/$archive_name"

printf '%s\n' \
  "Version:      $version" \
  "Download:     $download_url" \
  "Install to:   $install_dir" \
  "Stable link:  $stable_link" \
  "Command link: $command_link"

[ "$dry_run" = false ] || exit 0

require_command unzip
require_command mktemp

if [ -e "$stable_link" ] && [ ! -L "$stable_link" ]; then
  die "will not replace non-symlink path: $stable_link"
fi

if [ -e "$command_link" ] && [ ! -L "$command_link" ]; then
  die "will not replace non-symlink path: $command_link"
fi

if [ -d "$install_dir" ]; then
  [ -x "$install_dir/arduino-ide" ] || \
    die "install directory exists but has no executable: $install_dir/arduino-ide"
  printf 'Reusing existing installation: %s\n' "$install_dir"
else
  temp_dir=$(mktemp -d)
  trap 'rm -rf "$temp_dir"' EXIT HUP INT TERM

  printf 'Downloading Arduino IDE %s...\n' "$version"
  curl --fail --location --show-error --retry 3 \
    --output "$temp_dir/$archive_name" "$download_url"

  mkdir -p "$temp_dir/extracted"
  unzip -q "$temp_dir/$archive_name" -d "$temp_dir/extracted"

  executable=$(find "$temp_dir/extracted" -type f -name arduino-ide -perm -u+x -print -quit)
  [ -n "$executable" ] || die "the archive does not contain an Arduino IDE executable"

  extracted_dir=$(dirname "$executable")
  mkdir -p "$install_root"
  mv "$extracted_dir" "$install_dir"
fi

mkdir -p "$bin_dir"
ln -sfn "$install_dir" "$stable_link"
ln -sfn "$stable_link/arduino-ide" "$command_link"

printf '\nInstalled Arduino IDE %s. Start it with:\n\n  arduino-ide\n' "$version"

case ":$PATH:" in
  *:"$bin_dir":*) ;;
  *) printf '\nNote: add %s to PATH to use the command.\n' "$bin_dir" ;;
esac
