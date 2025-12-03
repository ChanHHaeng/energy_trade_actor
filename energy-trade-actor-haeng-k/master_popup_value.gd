extends LineEdit


var prev_text=""
var value=0

func _on_text_changed(new_text: String) -> void:
	if text=="":
		prev_text=text
		value=0
	elif not text.is_valid_int(): ##이전 텍스트로 돌아가기
		self.text=prev_text
		caret_column = text.length()
	else: ##올바른 텍스트
		prev_text=text
		value=int(text)
	$"..".possible_check()
