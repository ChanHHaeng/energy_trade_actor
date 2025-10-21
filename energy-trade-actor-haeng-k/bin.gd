extends TextureRect

var acting=false
@onready var activate=load("res://assets/realbin_activate.svg")
@onready var deactivate=load("res://assets/realbin.svg")

func _on_mouse_entered() -> void:
	if Global.focusing!=null:
		self.texture=activate
		Global.focusing.bin_activated=true
	


func _on_mouse_exited() -> void:
	if Global.focusing!=null:
		self.texture=deactivate
		Global.focusing.bin_activated=false


func return_to_deactivate():
	self.texture=deactivate


func _on_gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return
	if event.button_index != MOUSE_BUTTON_LEFT: return
	if event.is_pressed():
		$"../HBoxContainer".queue_redraw()
		if !acting:
			self.texture=activate
			acting=true
			for i in get_node("../HBoxContainer").get_children():
				i.get_node("AnimationPlayer").play("wiggle")
				i.delmode()
		else:
			self.texture=deactivate
			acting=false
			for i in get_node("../HBoxContainer").get_children():
				i.get_node("AnimationPlayer").stop()
				i.get_node("AnimationPlayer").play("RESET")
				i.normalmode()
				
func disabbled():
	self.texture=deactivate
	acting=false
	for i in get_node("../HBoxContainer").get_children():
		i.get_node("AnimationPlayer").stop()
		i.get_node("AnimationPlayer").play("RESET")
		i.normalmode()
				
	
