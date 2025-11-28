extends SpinBox


func _ready() -> void:
	self. value=Global.building_id

func _on_value_changed(value: float) -> void:
	Global.building_id=int(value)
	if value == 0:
		$"../HBoxContainer/My Page".text="Master"
	else:
		$"../HBoxContainer/My Page".text="My page"
		
		
