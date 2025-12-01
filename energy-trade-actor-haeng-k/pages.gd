extends Control


func _on_optioncontainer_child_entered_tree(node: Node) -> void:
	get_child(0).dataset()


func _on_optioncontainer_child_exiting_tree(node: Node) -> void:
	get_child(0).dataset()
