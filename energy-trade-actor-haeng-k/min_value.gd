extends LineEdit

var prev_text=""
var correct_form=false
var value:int
func _ready() -> void:
	pass
	#placeholder_text=self.name
	text_changed.connect(texts_changed)
	self.cancel_ime()
	#virtual_keyboard_type=KEYBOARD_TYPE_NUMBER
	## 7<X 가 발동하지 않는중
func texts_changed(new_text):
	print("changed!")
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
	
#func texts_changed(new_text):
	#var filtered = ""
	#var bytes = text.to_utf8_buffer()
	#
	#for byte in bytes:
		## ASCII 숫자(48-57)만 허용
		#if byte >= 48 and byte <= 57:
			#filtered += char(byte)
	#
	#if filtered != text:
		#self.text = filtered
		#caret_column = filtered.length()
	#
	#prev_text = filtered
	#value = int(filtered) if filtered != "" else 0

func _on_gui_input(event: InputEvent) -> void:
	print("gogo")
	if event is InputEventKey and event.pressed and not event.echo:
		var key_char = char(event.unicode)
		if not key_char.is_valid_int() and event.keycode != KEY_BACKSPACE and event.keycode != KEY_DELETE:
			accept_event()  # 이벤트 소비하여 입력 차단
