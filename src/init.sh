function init() {
	if [ -f "$NOTEBOOK" ]; then
		load_notebook "$NOTEBOOK"
	elif [ -d "$NOTEBOOK" ]; then
		export NOTEBOOKS="$NOTEBOOK"
		local md_files="$(find $NOTEBOOKS -maxdepth 1 -type f -name '*.md')"
		local md_count="$(echo "$md_files" | sed '/^\s*$/d' | wc -l)" # sed removed blank lines

		case "$md_count" in
		0)
			print_error "No notebooks found in '$NOTEBOOKS'."
			;;
		1)
			load_notebook "$md_files"
			;;
		*)
			set_notebook_name "Notebooks Explorer"
			notebooks_explorer
			;;
		esac
	else
		print_error "'$NOTEBOOK' does not exist."
	fi
}
