extends Panel


@onready var amount_line=%Amount_line

@onready var price_line=%price_line


var _amount: String = ""

@export var amount: String:
	set(value):
		_amount = value
		if amount_line:          # null 체크
			amount_line.text = value
	get:
		if amount_line:
			return amount_line.text
		return _amount
var _price : String =""

@export var price: String:
	set(value):
		_price = value
		if price_line:          # null 체크
			price_line.text = value
	get:
		if price_line:
			return price_line.text
		return _price


func _ready() -> void:
	amount_line.text=_amount
	price_line.text=_price
func _on_suicide_button_pressed() -> void:
	queue_free()



func _on_line_edit_editing_toggled(toggled_on: bool) -> void:
	self.amount=$LineEdit.text


func _on_line_edit_2_editing_toggled(toggled_on: bool) -> void:
	self.price=$LineEdit2.text
