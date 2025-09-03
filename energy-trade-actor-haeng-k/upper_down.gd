extends Panel




func _on_resized() -> void:
	self.position.x=40-(self.size.x)/2
	#$HBoxContainer.size=self.size-Vector2(6,6)
