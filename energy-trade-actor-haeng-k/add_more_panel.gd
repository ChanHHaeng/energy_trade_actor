extends Button

var disabling=false
@onready var example=load("res://data_example.tscn")
@onready var example_buy=load("res://assets/data_example_buy.tres")
@onready var example_sell=load("res://assets/data_example_sell.tres")
var cardlen=Global.cardlen

var count=0
func _on_pressed() -> void:
	$"..".size.x+=cardlen
	$"../HBoxContainer".size.x+=cardlen
	var examples=example.instantiate()
	if get_parent().name=="down":
		examples.get_node("SubViewport/Panel").add_theme_stylebox_override('panel',example_sell)
	examples.name=str(count+1)
	count+=1
	$"../TextureRect".disabbled()
	$"../HBoxContainer".add_child(examples)
	$"../HBoxContainer".set_anchors_preset(Control.PRESET_CENTER)
	$"../HBoxContainer".set_offsets_preset(Control.PRESET_CENTER)
	examples.presentation()
	if len($"../HBoxContainer".get_children())!=5:
		self.disabling=false
		self.visible=true
	
