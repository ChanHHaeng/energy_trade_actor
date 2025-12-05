extends LineEdit

enum line_model{Amount,price,Total}

@onready var total_line_down=load("res://assets/total_Line_Down.tres")

@export var ops_mode : line_model
var prev_text=""
var correct_form=false
func _ready() -> void:
	text_changed.connect(texts_changed)
	#if ops_mode==line_model.Total and get_owner().get_node("../..").ops_mode==1:
		#self.add_theme_stylebox_override("read_only",total_line_down)

func texts_changed(new_text):
	if text=="":#아무것도 없을때
		prev_text=text
		correct_form=false
	elif not text.is_valid_int(): #int가 아닐때
		self.text=prev_text
		caret_column = text.length()
		correct_form=false
	elif ops_mode==line_model.Amount and int(text)>100: #100을 초과했을 때
		text="100"
		prev_text=text
		correct_form=true
	elif ops_mode==line_model.price and int(text)>1000:
		text="1000"
		prev_text=text
		correct_form=true
	else:#올바른 입력
		prev_text=text
		correct_form=true
		if ops_mode==line_model.Amount:
			get_owner().amount=self.text
			caret_column = text.length()
		elif ops_mode==line_model.price:
			get_owner().price=self.text
			caret_column = text.length()
		#print("hehe")
		#print(get_owner().amount, " and " , get_owner().price)
	#$"../insert".possible_check()
	totalcheck()

func totalcheck():
	if %Amount_line.correct_form and %price_line.correct_form:
		totalling()

func totalling():
	%Total_line.text=str(int(get_owner().amount)*int(get_owner().price))
