extends Panel


var timetable = {
	6: [0, 0],
	7: [0, 0],
	8: [0, 0],
	9: [0, 0],
	10: [0, 0],
	11: [0, 0],
	12: [0, 0],
	13: [0, 0],
	14: [0, 0],
	15: [0, 0],
	16: [0, 0],
	17: [0, 0],
	18: [0, 0],
	19: [0, 0],
	20: [0, 0],
	21: [0, 0],
	22: [0, 0],
	23: [0, 0],
	0: [0, 0],
	1: [0, 0],
	2: [0, 0],
	3: [0, 0],
	4: [0, 0],
	5: [0, 0],
}



func react_input(flag:bool,node:Node):
	if flag:
		self.connect("gui_input",_on_gui_input.bind(node))
	elif !flag:
		self.disconnect("gui_input",_on_gui_input)		
		

func _on_gui_input(event: InputEvent,node:Node) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		node.button_pressed=false


#func _on_visibility_changed() -> void:
	#print(Global.buy_data)
	
func setting():
	#for i in range(24):
		#timetable.append([0,0])
	print("sorting!")
	for i in Global.buy_data:
		if int(i["building_id"])==Global.building_id:
			timetable[int(i["start_time"])][0]+=1
	for i in Global.sell_data:
		if int(i["building_id"])==Global.building_id:
			timetable[Global.building_id][1]+=1
	
	print(timetable)
	for i in $GridContainer.get_children():
		i.add_item(timetable[int(i.name)])
	for i in $GridContainer2.get_children():
		i.add_item(timetable[int(i.name)])
	pass
