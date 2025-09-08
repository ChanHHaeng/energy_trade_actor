extends Button

@onready var time_button_group=load("res://time_button_group.tres")
@onready var example=load("res://data_example.tscn")
@onready var example_sell=load("res://assets/data_example_sell.tres")


func _ready() -> void:
	$Upper.visible=false
	$down.visible=false
	self.button_group=time_button_group


func _on_toggled(toggled_on: bool) -> void:
	$Upper.visible=toggled_on
	$down.visible=toggled_on
	get_node("../..").react_input(toggled_on,self)


func add_item(array:Array):
	for i in range(array[0]):
		$Upper.size.x+=180
		$"Upper/HBoxContainer".size.x+=180
		var examples=example.instantiate()
		if get_parent().name=="down":
			examples.add_theme_stylebox_override('panel',example_sell)
		$"Upper/HBoxContainer".add_child(examples)
	for i in range(array[1]):
		$down.size.x+=180
		$"down/HBoxContainer".size.x+=180
		var examples=example.instantiate()
		if get_parent().name=="down":
			examples.add_theme_stylebox_override('panel',example_sell)
		$"down/HBoxContainer".add_child(examples)
	
