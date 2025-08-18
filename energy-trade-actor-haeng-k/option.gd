extends Label

enum options {
	
}

func _on_suicide_button_pressed() -> void:
	queue_free()
