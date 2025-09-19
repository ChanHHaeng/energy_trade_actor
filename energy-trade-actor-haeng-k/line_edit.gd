extends LineEdit

var prev_text
var correct_form
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
	elif int(text)>100:
		text="100"
		prev_text=text
		correct_form=true
	else:
		prev_text=text
		correct_form=true
	#$"../insert".possible_check()
