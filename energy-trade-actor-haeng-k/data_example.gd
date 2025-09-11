extends Panel

var amount=""
var price=""

func _on_suicide_button_pressed() -> void:
	queue_free()



func _on_line_edit_editing_toggled(toggled_on: bool) -> void:
	self.amount=$LineEdit.text


func _on_line_edit_2_editing_toggled(toggled_on: bool) -> void:
	self.price=$LineEdit2.text
