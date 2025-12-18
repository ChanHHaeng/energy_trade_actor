extends Button

var min:int
var max:int
@onready var optionscene=load("res://option.tscn")

func possible_check():
	min=$"../min price".value
	max=$"../max price".value
	if !(min==0 and max==0):
		if min<=max:
			disabled=false
		elif max==0:
			disabled=false
		else:
			disabled=true
	else:
		disabled=true


func _on_pressed() -> void:
	if %optioncontainer.get_node(str(get_parent().name)):
		%optioncontainer.get_node(str(get_parent().name)).free()
	var option=optionscene.instantiate()
	option.name=get_parent().name ##price 라는 이름의 가격 조건을 저장한 노드 생성
	if max==0:
		option.text=str(min)+" KRW and above"
	elif min==0:
		option.text=" UP to "+str(max)+" KRW"
	else:
		option.text=" "+str(min)+" - "+str(max)+" KRW"
	option.custom_minimum_size.x=option.get_minimum_size().x+30
	option.status=2 #status enum의 price로 입력
	%optioncontainer.add_child(option)
	$"../min price".value=0
	$"../min price".text=""
	$"../max price".value=0
	$"../max price".text=""
	self.disabled=true
