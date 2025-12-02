extends SpinBox


func _ready() -> void:
	self. value=Global.building_id

func _on_value_changed(values: float) -> void:
	Global.building_id=int(values)
	#if value == 0:
		#$"../HBoxContainer/My Page".text="Master"
	#else:
		#$"../HBoxContainer/My Page".text="My page"
		
		
