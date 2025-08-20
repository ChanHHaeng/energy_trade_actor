extends ColorRect


func _on_minimum_size_changed() -> void:
	print($ColorRect.size)
	$ColorRect.size=Vector2(self.custom_minimum_size.x-3,self.custom_minimum_size.y-3)
	print(self.custom_minimum_size.x-3)
	pass
