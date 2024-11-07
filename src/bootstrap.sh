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

function to_lowercase() {
	local str="$1"
	echo "$str" | tr '[:upper:]' '[:lower:]'
}

function ensure_dependency() {
	local command="$1"

	if [ ! -x "$(command -v "$command")" ]; then
		echo "Need '$command' to bootstrap. Please install it."
		exit 1
	fi
}

function bootstrap_binary() {
	local command="$1"
	local version="$2"
	local size="$3"
	local repo="$4"
	local archive_linux="$5"
	local archive_darwin="$6"
	local extract="$7"
	local archive=""
	local os="$(to_lowercase "$(uname -s)")"

	if [ "$os" = "linux" ]; then
		archive="$archive_linux"
	elif [ "$os" = "darwin" ]; then
		archive="$archive_darwin"
	else
		echo "Could not bootstrap '$command' for '$os'. Please install it yourself."
		return
	fi

	local url="https://github.com/$repo/releases/download/v$version/$archive"

	read -r -n 1 -p "Need to download dependency https://github.com/$repo ($version $size). Continue? [Y/n]: " response
	response="$(to_lowercase $response)"

	if [[ $response =~ ^(y| ) ]] || [[ -z $response ]]; then
		echo "Downloading '$archive'..."
		download_extract_copy "$url" "$extract" "$BIN_PATH"
	fi
}

function bootstrap() {
	local arch="$(to_lowercase "$(uname -m)")"

	ensure_dependency "curl"
	ensure_dependency "tar"

	if [ ! -x "$(command -v "zellij")" ] && [ ! -f "$ZEL" ]; then
		local zellij_linux="zellij-$arch-unknown-linux-musl.tar.gz"
		local zellij_darwin="zellij-$arch-apple-darwin.tar.gz"

		bootstrap_binary "zellij" "0.41.1" "~11MB" "zellij-org/zellij" "$zellij_linux" "$zellij_darwin" "zellij"
	fi

	if [ ! -x "$(command -v "gum")" ] && [ ! -f "$GUM" ]; then
		local gum_version="0.14.5"
		local gum_linux="gum_$(echo $gum_version)_Linux_$(echo $arch).tar.gz"
		local gum_darwin="gum_$(echo $gum_version)_Darwin_$(echo $arch).tar.gz"

		bootstrap_binary "gum" "$gum_version" "~4MB" "charmbracelet/gum" "$gum_linux" "$gum_darwin" "**/gum"
	fi
}
