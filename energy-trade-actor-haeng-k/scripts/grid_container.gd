@tool
extends GridContainer
const Script_path="res://scripts/values.gd"
func _ready() -> void:
	var scripts=load(Script_path)
	for i in get_children():
		if i is LineEdit:
			i.set_script(scripts)
