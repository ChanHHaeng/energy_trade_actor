extends Button

@onready var buttongroup : ButtonGroup=load("res://time_button_group.tres")

func _on_pressed() -> void:
	for i in buttongroup.get_buttons():
		i.button_pressed=false
	await get_tree().process_frame
	print("reset start!---------------")
	for i in $"../GridContainer".get_children():
		i.reset()
	for i in $"../GridContainer2".get_children():
		i.reset()
	
	$"..".resetting()
	
