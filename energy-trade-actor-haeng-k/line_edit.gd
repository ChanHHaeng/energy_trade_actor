extends LineEdit

var prev_text=""
var correct_form
func _ready() -> void:
	text_changed.connect(texts_changed)

func texts_changed(new_text):
	if text=="":#아무것도 없을때
		prev_text=text
		correct_form=false
	elif not text.is_valid_int(): #int가 아닐때
		self.text=prev_text
		caret_column = text.length()
		correct_form=false
	elif self==%Amount_line and int(text)>100: #100을 초과했을 때
		text="100"
		prev_text=text
		correct_form=true
	else:#올바른 입력
		prev_text=text
		correct_form=true
		if self==%Amount_line:
			get_owner().amount=self.text
			caret_column = text.length()
		elif self==%price_line:
			get_owner().price=self.text
			caret_column = text.length()
		#print("hehe")
		#print(get_owner().amount, " and " , get_owner().price)
	#$"../insert".possible_check()
	
	
	if %Amount_line.correct_form and %price_line.correct_form:
		totalling()

func totalling():
	%Total_line.text=str(int(get_owner().amount)*int(get_owner().price))
