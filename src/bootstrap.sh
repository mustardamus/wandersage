function download_extract_copy() {
  local url="$1"
  local glob="$2"
  local dest="$3"
  local archive="$(mktemp -d)/$(basename $url)"
  local tmp="$(mktemp -d)"

  curl -sSLo "$archive" "$url"
  tar -C "$tmp" -zxf "$archive"
  mkdir -p "$dest"
  cp "$(find $tmp/$glob)" "$dest/"
  rm "$archive"
  rm -rf "$tmp"
}

function download_confirm() {
  local dep="$1"
  local size="$2"

  read -r -p "Need to download dependency '$dep' ($size). Continue? [Y/n]" response
  response=${response,,} # lowercase

  if [[ $response =~ ^(y| ) ]] || [[ -z $response ]]; then
    echo "true"
  fi
}

function bootstrap() {
  local zellij_version="0.40.1"
  local gum_version="0.14.1"
  local zellij_url="https://github.com/zellij-org/zellij/releases/download/v$zellij_version/zellij-x86_64-unknown-linux-musl.tar.gz"
  local gum_url="https://github.com/charmbracelet/gum/releases/download/v$gum_version/gum_$(echo $gum_version)_Linux_x86_64.tar.gz"

  if [ ! -x "$(command -v "curl")" ]; then
    echo "Need 'curl' to bootstrap. Please install it."
    exit 1
  fi

  if [ ! -x "$(command -v "tar")" ]; then
    echo "Need 'tar' to bootstrap. Please install it."
    exit 1
  fi

  if [ ! -f "$ZEL" ] && [ "$(download_confirm "Zellij" "~11MB")" = "true" ]; then
    echo "Downloading 'Zellij' ($zellij_version)..."
    download_extract_copy "$zellij_url" "zellij" "$BIN_PATH"
  fi

  if [ ! -f "$GUM" ] && [ "$(download_confirm "Gum" "~4MB")" = "true" ]; then
    echo "Downloading 'Gum' ($gum_version)..."
    download_extract_copy "$gum_url" "**/gum" "$BIN_PATH"
  fi
}
