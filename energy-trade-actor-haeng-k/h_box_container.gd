extends HBoxContainer



	
func _on_child_exiting_tree(node: Node) -> void:
	print(get_children())
	self.size.x-=180
	$"..".size.x-=180


func _input(event: InputEvent) -> void:
	if get_parent().visible:
		if event.is_action_pressed("k"):
			print(get_children())
			if len(get_children())==1:
				print(get_child(0).size)
