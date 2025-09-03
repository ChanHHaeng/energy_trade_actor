extends Button

@onready var example=load("res://data_example.tscn")
@onready var glass=load("res://themes/greenglass.tres")

func _on_pressed() -> void:
	$"..".size.x+=180
	$"../HBoxContainer".size.x+=180
	var examples=example.instantiate()
	if get_parent().name=="down":
		examples.add_theme_stylebox_override('panel',glass)
	$"../HBoxContainer".add_child(examples)
