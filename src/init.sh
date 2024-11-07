function init() {
	if [ -f "$NOTEBOOK" ]; then
		load_notebook "$NOTEBOOK"
	elif [ -d "$NOTEBOOK" ]; then
		export NOTEBOOKS="$NOTEBOOK"
		set_notebook_name "Notebooks Explorer"
		notebooks_explorer
	else
		print_error "'$NOTEBOOK' does not exist."
	fi
}
