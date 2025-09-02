extends SpinBox


func _on_value_changed(value: float) -> void:
	Global.building_id=int(value)
