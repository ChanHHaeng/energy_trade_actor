extends Button




func _on_pressed() -> void:
	Global.building_id=0
	%login_plate.activate()
	$"..".visible=false
