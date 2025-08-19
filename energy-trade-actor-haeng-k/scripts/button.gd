extends Button

#@export var hover_scale: Vector2 = Vector2(1.08, 1.08)
#@export var pressed_scale: Vector2 = Vector2(0.93, 0.87)
#@export var tween_time: float = 0.12


func _ready() -> void:
	if Global.building_id==0 and name=="My Page":
		self.text="master"
	
	
func _on_toggled(toggled_on: bool) -> void:
	
	get_node("../../Panel/"+self.name+" page").visible=toggled_on
	#if not toggled_on:
		#get_node("../../Panel/"+self.name+" page").get_child(0).
