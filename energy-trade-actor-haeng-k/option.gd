extends Button

enum options {
	time,
	value,
	price
}

var blue_theme=load("res://themes/option_price_normal.tres")
var pressed_blue_theme=load("res://themes/option_price_pressed.tres")

var _status
@export var status:options:
	set(value):
		if value==2:
			self.add_theme_stylebox_override("normal",blue_theme)
			self.add_theme_stylebox_override("hover",blue_theme)
			self.add_theme_stylebox_override("pressed",pressed_blue_theme)



func _on_pressed() -> void:
	queue_free()
