extends Button



func _on_pressed() -> void:
	print("reset start!---------------")
	for i in $"../GridContainer".get_children():
		i.reset()
	for i in $"../GridContainer2".get_children():
		i.reset()
	
	$"..".resetting()
	
