extends Panel




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
	print(Global.buy_data)
