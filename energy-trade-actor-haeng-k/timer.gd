extends Button

@onready var time_button_group=load("res://time_button_group.tres")
@onready var example=load("res://data_example.tscn")
@onready var example_sell=load("res://assets/data_example_sell.tres")
@onready var example_buy=load("res://assets/data_example_buy.tres")


var data=[[],[]]
var upper
var down
func _ready() -> void:
	$Upper.visible=false
	$down.visible=false
	self.button_group=time_button_group


func _on_toggled(toggled_on: bool) -> void:
	$Upper.circularation(toggled_on)
	$down.circularation(toggled_on)
	get_node("../..").react_input(toggled_on,self)
	if toggled_on:
		print("check!")
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
	for i in range(len(array[0])):
		#if !$Upper.resize_flag:
			#await 
		$Upper.size.x+=180
		print("upper size changed!")
		print($Upper.resize_flag)
		$Upper.size.y=80
		$"Upper/HBoxContainer".size.x+=180
		var examples=example.instantiate()
		examples.amount=str(array[0][i][0])
		examples.price=str(array[0][i][1])
		$"Upper/HBoxContainer".add_child(examples)
	for i in range(len(array[1])):
		$down.size.x+=180
		$down.size.y=80
		$"down/HBoxContainer".size.x+=180
		var examples=example.instantiate()
		examples.amount=str(array[1][i][0])
		examples.price=str(array[1][i][1])
		examples.add_theme_stylebox_override('panel',example_sell)
		$"down/HBoxContainer".add_child(examples)
	stacking()
	
func stacking(): #테이블 숫자 세서 stack label에 표시
	upper=len($Upper/HBoxContainer.get_children())
	down = len($down/HBoxContainer.get_children())
	if upper==0:
		$"Upper stack".text=""
		$"Upper stack".visible=false
	elif upper<9:
		$"Upper stack".visible=true
		$"Upper stack".text = str(len($Upper/HBoxContainer.get_children()))
	else:
		$"Upper stack".text="9+"
		$"Upper stack".visible=true
		
	if down==0:
		$"Down stack".text=""
		$"Down stack".visible=false
	elif down<9:
		$"Down stack".text = str(len($down/HBoxContainer.get_children()))
		$"Down stack".visible=true
	else:
		$"Down stack".text="9+"
		$"Down stack".visible=true
	get_node("../..").timetable[int(name)]=[upper,down]


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
	for i in $Upper/HBoxContainer.get_children():
		if i.amount=="" or i.price=="":
			i.free()
			get_node("../../../../..").show_warring()
	for i in $down/HBoxContainer.get_children():
		if i.amount=="" or i.price=="":
			i.free()
			get_node("../../../../..").show_warring()
	#down = len($down/HBoxContainer.get_children())
