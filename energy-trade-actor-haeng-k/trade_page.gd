extends Panel


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



func react_input(flag:bool,node:Node):
	if flag:
		self.connect("gui_input",_on_gui_input.bind(node))
	elif !flag:
		self.disconnect("gui_input",_on_gui_input)		
		

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
		#print("timetable is")
		#print(timetable[int(i.name)])
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
