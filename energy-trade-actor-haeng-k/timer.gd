extends Button

@onready var time_button_group=load("res://time_button_group.tres")
@onready var example=load("res://data_example.tscn")
@onready var example_sell=load("res://assets/data_example_sell.tres")
@onready var example_buy=load("res://assets/data_example_buy.tres")

var cardlen=Global.cardlen

var data=[[],[]]
var upper
var down
var checkingmode = false

var no_color = Color(0.882, 0.882, 0.882)
var yes_color = Color(0.48, 0.48, 0.48)
func _ready() -> void:
	$CanvasLayer/Upper.visible=false
	$CanvasLayer/down.visible=false
	self.button_group=time_button_group


func _on_toggled(toggled_on: bool) -> void:
	$CanvasLayer/Upper.circularation(toggled_on)
	$CanvasLayer/down.circularation(toggled_on)
	get_node("../..").react_input(toggled_on,self)
	if toggled_on:
		$"Upper stack".text=""
		$"Upper stack".visible=false
		$"Down stack".text=""
		$"Down stack".visible=false
		$upperfold.visible=false
		$downfold.visible=false
	if not toggled_on:
		checking()
		stacking()

func add_item(array:Array):
	data=array
	if len(array[0]):
		$CanvasLayer/Upper.size_memory.x=80
	if len(array[1]):
		$CanvasLayer/down.size_memory.x=80
	for i in range(len(array[0])):
		$CanvasLayer/Upper.size_memory.x+=cardlen
		$CanvasLayer/Upper.size_memory.y=200
		$CanvasLayer/Upper/HBoxContainer.size.x+=cardlen
		var examples=example.instantiate()
		examples.amount=str(array[0][i][0])
		examples.price=str(array[0][i][1])
		$CanvasLayer/Upper/HBoxContainer.add_child(examples)
	for i in range(len(array[1])):
		$CanvasLayer/down.size_memory.x+=cardlen
		$CanvasLayer/down.size_memory.y=200
		$CanvasLayer/down/HBoxContainer.size.x+=cardlen
		var examples=example.instantiate()
		examples.amount=str(array[1][i][0])
		examples.price=str(array[1][i][1])
		examples.get_node("SubViewport/Panel").add_theme_stylebox_override('panel',example_sell)
		$CanvasLayer/down/HBoxContainer.add_child(examples)
	stacking()
	
func stacking(): #테이블 숫자 세서 stack label에 표시
	upper=len($CanvasLayer/Upper/HBoxContainer.get_children())
	down = len($CanvasLayer/down/HBoxContainer.get_children())
	if upper==0:
		$"Upper stack".text=""
		$"Upper stack".visible=false
	elif upper<9:
		$"Upper stack".visible=true
		$"Upper stack".text = str(len($CanvasLayer/Upper/HBoxContainer.get_children()))
	else:
		$"Upper stack".text="9+"
		$"Upper stack".visible=true
		
	if down==0:
		$"Down stack".text=""
		$"Down stack".visible=false
	elif down<9:
		$"Down stack".text = str(len($CanvasLayer/down/HBoxContainer.get_children()))
		$"Down stack".visible=true
	else:
		$"Down stack".text="9+"
		$"Down stack".visible=true
	#get_node("../..").timetable[int(name)]=[upper,down]


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
		
		
func checking(): ## 빈 테이블 정리
	checkingmode=true
	for i in $CanvasLayer/Upper/HBoxContainer.get_children():
		if i.amount=="" or i.price=="":
			i.free()
			get_node("../../../../..").show_warring()
	for i in $CanvasLayer/down/HBoxContainer.get_children():
		if i.amount=="" or i.price=="": 
			i.free()
			get_node("../../../../..").show_warring()
	await get_tree().process_frame
	checkingmode=false
			
func reset():
	for i in $CanvasLayer/Upper/HBoxContainer.get_children():
		i.queue_free()
	for i in $CanvasLayer/down/HBoxContainer.get_children():
		i.queue_free()
	$CanvasLayer/Upper.resize_flag=true
	%down.resize_flag=true
	
func gain_data() -> Array:
	var new_data=[%Upper.get_data(),%down.get_data()]
	return new_data
