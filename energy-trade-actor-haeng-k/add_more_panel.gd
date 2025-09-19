extends Button

var disabling=false
@onready var example=load("res://data_example.tscn")
@onready var example_buy=load("res://assets/data_example_buy.tres")
@onready var example_sell=load("res://assets/data_example_sell.tres")

var count=0
func _on_pressed() -> void:
	$"..".size.x+=180
	$"../HBoxContainer".size.x+=180
	var examples=example.instantiate()
	if get_parent().name=="down":
		examples.add_theme_stylebox_override('panel',example_sell)
	examples.name=str(count+1)
	count+=1
	$"../HBoxContainer".add_child(examples)
