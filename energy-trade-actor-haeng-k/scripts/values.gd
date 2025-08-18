extends LineEdit

var prev_text=""
var correct_form=false
func _ready() -> void:
	text_changed.connect(texts_changed)
	
	
func texts_changed(new_text):
	if text=="":
		prev_text=text
		correct_form=false
	elif not text.is_valid_int():
		self.text=prev_text
		caret_column = text.length()
		correct_form=false
	else:
		prev_text=text
		correct_form=true
		get_parent().get_parent().get_child(2).disabling()
