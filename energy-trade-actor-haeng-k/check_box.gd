extends Button


var checkbox_normal=load("res://themes/checkbox_normal.tres")
var checkbox_selected = load("res://themes/checkbox_selected.tres")

func _on_mouse_entered() -> void:
	#$Label.add_theme_color_override("font_color",Color(0.173, 0.0, 0.886))
	pass




func _on_mouse_exited() -> void:
	#$Label.add_theme_color_override("font_color",Color(0,0,0))
	pass




func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$Panel/Panel.position.x=22
		$Panel.add_theme_stylebox_override("panel",checkbox_selected)
	else:
		$Panel.add_theme_stylebox_override("panel",checkbox_normal)
		$Panel/Panel.position.x=3
	
	%buy.onlymine=toggled_on
	%sell.onlymine=toggled_on
	%buy.dataset()
	%sell.dataset()
