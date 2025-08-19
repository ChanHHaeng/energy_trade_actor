extends Label

enum options {
	time,
	values,
	prices
}

var status:options

func _on_suicide_button_pressed() -> void:
	queue_free()
