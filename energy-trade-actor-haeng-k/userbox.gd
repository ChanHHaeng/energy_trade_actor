extends ColorRect


func _on_minimum_size_changed() -> void:
	$ColorRect.size=Vector2(self.custom_minimum_size.x-6,self.custom_minimum_size.y-6)
	pass
