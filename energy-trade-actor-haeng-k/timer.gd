extends Button

@onready var time_button_group=load("res://time_button_group.tres")
@onready var example=load("res://data_example.tscn")
@onready var example_sell=load("res://assets/data_example_sell.tres")
@onready var example_buy=load("res://assets/data_example_buy.tres")

var upper
var down
func _ready() -> void:
	$Upper.visible=false
	$down.visible=false
	self.button_group=time_button_group


func _on_toggled(toggled_on: bool) -> void:
	$Upper.visible=toggled_on
	$down.visible=toggled_on
	get_node("../..").react_input(toggled_on,self)
	if toggled_on:
		print("check!")
		$"Upper stack".text=""
		$"Down stack".text=""
		$upperfold.visible=false
		$downfold.visible=false
	if not toggled_on:
		stacking()

func add_item(array:Array):
	for i in range(array[0]):
		$Upper.size.x+=180
		$"Upper/HBoxContainer".size.x+=180
		var examples=example.instantiate()
		$"Upper/HBoxContainer".add_child(examples)
	for i in range(array[1]):
		$down.size.x+=180
		$"down/HBoxContainer".size.x+=180
		var examples=example.instantiate()
		examples.add_theme_stylebox_override('panel',example_sell)
		$"down/HBoxContainer".add_child(examples)
	stacking()
	
func stacking():
	upper=len($Upper/HBoxContainer.get_children())
	down = len($down/HBoxContainer.get_children())
	if upper==0:
		$"Upper stack".text=""
	elif upper<9:
		$"Upper stack".text = str(len($Upper/HBoxContainer.get_children()))
	else:
		$"Upper stack".text="9+"
		
	if down==0:
		$"Down stack".text=""
	elif down<9:
		$"Down stack".text = str(len($down/HBoxContainer.get_children()))
	else:
		$"Down stack".text="9+"


func _on_mouse_entered() -> void:
	if upper!=0 and upper!=null and !self.button_pressed:
		$upperfold.visible=true
		%AnimationPlayer_up.play("card_mousehover")
	if down!=0 and down!=null and !self.button_pressed:
		$downfold.visible=true
		%AnimationPlayer_down.play("card_mousehover_down")

func _on_mouse_exited() -> void:
	if upper!=0 and upper!=null:
		%AnimationPlayer_up.play("RESET")
		$upperfold.visible=false
	if down!=0 and down!=null:
		%AnimationPlayer_down.play("RESET")
		$downfold.visible=false
