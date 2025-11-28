extends Button

@onready var time_button_group=load("res://time_button_group.tres")
@onready var example=load("res://data_example.tscn")
@onready var example_sell=load("res://assets/data_example_sell.tres")
@onready var example_buy=load("res://assets/data_example_buy.tres")

var cardlen=Global.cardlen

var data=[[],[]]
var buy_amount
var sell_amount
var checkingmode = false

var no_color = Color(0.8, 0.8, 0.8)
var yes_color = Color(0.1, 0.1, 0.1)
func _ready() -> void:
	%"data plate".visible=false
	self.button_group=time_button_group

func _on_toggled(toggled_on: bool) -> void:
	get_node("../..").react_input(toggled_on,self)
	if toggled_on:
		get_node("../../../../../Blur").visible=true
		$CanvasLayer.visible=true
		%"data plate".visible=true
		%"total stack".text=""
		%"total stack".visible=false
		$upperfold.visible=false
		$downfold.visible=false
	if not toggled_on:
		$CanvasLayer.visible=false
		%"data plate".visible=false
		checking()
		stacking()
		get_node("../../../../../Blur").visible=false

func add_item(array:Array):
	data=array
	for i in range(len(array[0])):
		var examples=example.instantiate()
		examples.amount=str(array[0][i][0])
		examples.price=str(array[0][i][1])
		%buyDataContainer.add_child(examples)
	for i in range(len(array[1])):
		var examples=example.instantiate()
		examples.amount=str(array[1][i][0])
		examples.price=str(array[1][i][1])
		examples.get_node("SubViewport/Panel").add_theme_stylebox_override('panel',example_sell)
		%sellDataContainer.add_child(examples)
	stacking()
	
func stacking(): #테이블 숫자 세서 stack label에 표시
	buy_amount = len(%buyDataContainer.get_children())
	sell_amount = len(%sellDataContainer.get_children())
	if buy_amount+sell_amount==0:
		%"total stack".text=""
		%"total stack".visible=false
	else:
		%"total stack".text = str(buy_amount+sell_amount)
		%"total stack".visible=true
	get_node("../..").timetable[int(name)]=[buy_amount,sell_amount]


func _on_mouse_entered() -> void:
	if buy_amount!=0 and buy_amount!=null and !self.button_pressed:
		$upperfold.visible=true
		%AnimationPlayer_up.play("card_mousehover")
	if sell_amount!=0 and sell_amount!=null and !self.button_pressed:
		$downfold.visible=true
		%AnimationPlayer_down.play("card_mousehover_down")

func _on_mouse_exited() -> void:
	if buy_amount!=0 and buy_amount!=null:
		%AnimationPlayer_up.play("RESET")
		$upperfold.visible=false
	if sell_amount!=0 and sell_amount!=null:
		%AnimationPlayer_down.play("RESET")
		$downfold.visible=false
		
		
func checking(): ## 빈 테이블 정리
	checkingmode=true
	for i in %buyDataContainer.get_children():
		if i.amount=="" or i.price=="":
			i.free()
			get_node("../../../../..").show_warring()
	for i in %sellDataContainer.get_children():
		if i.amount=="" or i.price=="": 
			i.free()
			get_node("../../../../..").show_warring()
	await get_tree().process_frame
	checkingmode=false
			
func reset():
	for i in %buyDataContainer.get_children():
		i.queue_free()
	for i in %sellDataContainer.get_children():
		i.queue_free()
	
func gain_data() -> Array:
	var new_data=[%buyDataContainer.get_data(),%sellDataContainer.get_data()]
	return new_data
