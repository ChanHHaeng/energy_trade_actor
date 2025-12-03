extends Panel
var glassplate:StyleBoxFlat=load("res://assets/glassplate.tres").duplicate()

var _skew:float
@export_range(0.0,10.0,0.1) var skew:float:
	set(value):
		_skew=value
		if glassplate:
			var glassplate_skew=glassplate.skew
			glassplate_skew.x=value
			glassplate.skew=glassplate_skew
			self.add_theme_stylebox_override("panel", glassplate)


@onready var timetable = {
	6: [[], []],
	7: [[], []],
	8: [[], []],
	9: [[], []],
	10: [[], []],
	11: [[], []],
	12: [[], []],
	13: [[], []],
	14: [[], []],
	15: [[], []],
	16: [[], []],
	17: [[], []],
	18: [[], []],
	19: [[], []],
	20: [[], []],
	21: [[], []],
	22: [[], []],
	23: [[], []],
	0: [[], []],
	1: [[], []],
	2: [[], []],
	3: [[], []],
	4: [[], []],
	5: [[], []],
}

func activate():
	print("go")

func react_input(flag:bool,node:Node):
	if flag:
		%Blur.connect("gui_input",_on_gui_input.bind(node))
	elif !flag:
		%Blur.disconnect("gui_input",_on_gui_input)		
		

func _on_gui_input(event: InputEvent,node:Node) -> void: #화면 아무곳이나 누르면 버튼 비활성화 되는 코드
	if event is InputEventMouseButton and event.is_pressed():
		node.button_pressed=false




func _on_visibility_changed() -> void:
	if visible and $"../../..".data_ready:
		setting()
	
func setting():
	timetable_clear()
	for i in Global.buy_data:
		if int(i["building_id"])==Global.building_id:
			timetable[int(i["start_time"])][0].append([int(i["buy"]),int(i["price"])])
	for i in Global.sell_data:
		if int(i["building_id"])==Global.building_id:
			timetable[int(i["start_time"])][1].append([int(i["sell"]),int(i["price"])])
	
	
	for i in $GridContainer.get_children():
		i.reset()
		i.add_item(timetable[int(i.name)])
	
	for i in $GridContainer2.get_children():
		i.reset()
		i.add_item(timetable[int(i.name)])
	pass

func resetting():
	for i in $GridContainer.get_children():
		i.add_item(timetable[int(i.name)])
	for i in $GridContainer2.get_children():
		i.add_item(timetable[int(i.name)])


func timetable_clear():
	timetable = {
	6: [[], []],
	7: [[], []],
	8: [[], []],
	9: [[], []],
	10: [[], []],
	11: [[], []],
	12: [[], []],
	13: [[], []],
	14: [[], []],
	15: [[], []],
	16: [[], []],
	17: [[], []],
	18: [[], []],
	19: [[], []],
	20: [[], []],
	21: [[], []],
	22: [[], []],
	23: [[], []],
	0: [[], []],
	1: [[], []],
	2: [[], []],
	3: [[], []],
	4: [[], []],
	5: [[], []],
}


func change_window():
	var catalogue_page=get_node("../Catalogue page")
	var my_page=get_node("../My Page page")
	var magni=Vector2(0.7,0.7)
	var length=800
	catalogue_page.scale=magni
	my_page.scale=magni
	catalogue_page.visible=true
	my_page.visible=true
	catalogue_page.z_index=2
	my_page.z_index=2
	catalogue_page.position.x+=length
	my_page.position.x-=length
	var tween=create_tween()
	tween.parallel().tween_property(self,"scale",magni,0.2)
	tween.tween_callback(
		func ():
			%Blur.visible=true
			self.z_index=2
			await get_tree().create_timer(0.4).timeout
			var tween2=create_tween()
			tween2.parallel().tween_property(my_page,"position",my_page.position-Vector2(400,0),0.1)
			my_page.position=Vector2(1216,16)
			tween2.parallel().tween_property(my_page,"position",Vector2(816,16),0.3)
			tween2.parallel().tween_property(self,"position",Vector2(-784,16),0.4)
			tween2.parallel().tween_property(catalogue_page,"position",Vector2(16,16),0.4)
	)
