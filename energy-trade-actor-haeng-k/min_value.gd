extends LineEdit

var prev_text=""
var correct_form=false
var value:int
func _ready() -> void:
	placeholder_text=self.name
	text_changed.connect(texts_changed)
	
	## 7<X 가 발동하지 않는중
func texts_changed(new_text):
	if text=="":
		prev_text=text
		value=0
	elif not text.is_valid_int(): ##이전 텍스트로 돌아가기
		self.text=prev_text
		caret_column = text.length()
	else: ##올바른 텍스트
		prev_text=text
		value=int(text)
	$"../insert".possible_check()
