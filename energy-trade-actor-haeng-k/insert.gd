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
		disabled=false


func _on_pressed() -> void:
	print(%optioncontainer.get_children())
	if $"../../optioncontainer".get_node(str(get_parent().name)):
		$"../../optioncontainer".get_node(str(get_parent().name)).free()
	var option=optionscene.instantiate()
	option.name=get_parent().name ##이쪽 부분 수정하면 될 것
	if max==0:
		option.text=" "+option.name+" "+str(min)+"~"
	elif min==0:
		option.text=" "+option.name+" "+"~"+str(max)
	else:
		option.text=" "+option.name+" "+str(min)+"~"+str(max)
	option.custom_minimum_size.x=option.get_minimum_size().x+30
	option.status=option.options[str(option.name)]
	$"../../optioncontainer".add_child(option)
	$"../min price".value=0
	$"../min price".text=""
	$"../max price".value=0
	$"../max price".text=""
	self.disabled=true
