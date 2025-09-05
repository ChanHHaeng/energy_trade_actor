extends Button

@onready var time_button_group=load("res://time_button_group.tres")

func _ready() -> void:
	$Upper.visible=false
	$down.visible=false
	self.button_group=time_button_group


func _on_toggled(toggled_on: bool) -> void:
	$Upper.visible=toggled_on
	$down.visible=toggled_on
	get_node("../..").react_input(toggled_on,self)
