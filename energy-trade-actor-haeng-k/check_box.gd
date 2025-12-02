extends Button


var checkbox_normal=load("res://themes/checkbox_back.tres")
var checkbox_selected = load("res://themes/checkbox_selected.tres")

@onready var border=get_node("border")
@onready var background=get_node("border/background")
@onready var toggle=get_node("border/background/toggle")
enum togglemode{
	mine,today
}

@export var mode:togglemode
func _on_mouse_entered() -> void:
	#$Label.add_theme_color_override("font_color",Color(0.173, 0.0, 0.886))
	pass




func _on_mouse_exited() -> void:
	#$Label.add_theme_color_override("font_color",Color(0,0,0))
	pass




func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		toggle.position.x=30
		#background.add_theme_stylebox_override("panel",checkbox_selected)
	else:
		toggle.position.x=2
		#background.add_theme_stylebox_override("panel",checkbox_normal)
	
	if self.mode==0:
		%buy.onlymine=toggled_on
		%sell.onlymine=toggled_on
		%buy.dataset()
		%sell.dataset()
	elif self.mode==1:
		%buy.onlytoday=toggled_on
		%sell.onlytoday=toggled_on
		%buy.dataset()
		%sell.dataset()
