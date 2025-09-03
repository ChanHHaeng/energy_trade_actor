extends VBoxContainer




func _on_child_entered_tree(node: Node) -> void:
	if Global.building_id!=0:
		if node.buyer!=Global.building_id and node.seller!=Global.building_id:
			node.visible=false
