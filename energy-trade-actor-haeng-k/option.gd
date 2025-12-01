extends Button

enum options {
	time,
	value,
	price
}

var status:options




func _on_pressed() -> void:
	queue_free()
