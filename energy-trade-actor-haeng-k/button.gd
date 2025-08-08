extends Button

#@export var hover_scale: Vector2 = Vector2(1.08, 1.08)
#@export var pressed_scale: Vector2 = Vector2(0.93, 0.87)
#@export var tween_time: float = 0.12


func _on_toggled(toggled_on: bool) -> void:
	$Line2D.visible=!toggled_on
