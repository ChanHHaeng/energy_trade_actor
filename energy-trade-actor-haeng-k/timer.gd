extends Button


func _ready() -> void:
	$Upper.visible=false
	$down.visible=false


func _on_toggled(toggled_on: bool) -> void:
	print(button_group)
	$Upper.visible=toggled_on
	$down.visible=toggled_on
