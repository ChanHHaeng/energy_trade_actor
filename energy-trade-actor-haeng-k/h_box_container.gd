extends HBoxContainer



	
func _on_child_exiting_tree(node: Node) -> void:
	await get_tree().process_frame
	for i in range(len(get_children())):
		if get_parent().name=="down":
			$"../../downfold".get_child(i).visible=true
		else:
			$"../../upperfold".get_child(i).visible=true
	for i in range(len(get_children()),5,1):
		if get_parent().name=="down":
			$"../../downfold".get_child(i).visible=false
		else:
			$"../../upperfold".get_child(i).visible=false
	if len(get_children())!=5:
		$"../Button".disabling=false
		$"../Button".visible=true
	self.size.x-=180
	$"..".size.x-=180


func _input(event: InputEvent) -> void:
	if get_parent().visible:
		if event.is_action_pressed("k"):
			print(get_children())
			if len(get_children())==1:
				print(get_child(0).size)


func _on_child_entered_tree(node: Node) -> void:
	for i in range(len(get_children())):
		if get_parent().name=="down":
			$"../../downfold".get_child(i).visible=true
		else:
			$"../../upperfold".get_child(i).visible=true
	for i in range(len(get_children()),5,1):
		if get_parent().name=="down":
			$"../../downfold".get_child(i).visible=false
		else:
			$"../../upperfold".get_child(i).visible=false
	if len(get_children())==5:
		$"../Button".disabling=true
		$"../Button".visible=false
		
