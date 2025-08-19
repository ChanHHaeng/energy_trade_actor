extends Button

var min:int
var max:int
@onready var optionscene=load("res://option.tscn")

func possible_check():
	if get_parent().get_child(0).correct_form and get_parent().get_child(1).correct_form:
		if int(get_parent().get_child(0).text)<=int(get_parent().get_child(1).text):
			disabled=false
		else:
			disabled=true
	else:
		disabled=true


func _on_pressed() -> void:
	print(%optioncontainer.get_children())
	if $"../../optioncontainer".get_node(str(get_parent().name)):
		print("gogogo")
		$"../../optioncontainer".get_node(str(get_parent().name)).free()
	var option=optionscene.instantiate()
	min=int(get_parent().get_child(0).text)
	max=int(get_parent().get_child(1).text)
	option.name=get_parent().name
	print(option.name)
	option.text=" "+option.name+" "+str(min)+"~"+str(max)
	option.custom_minimum_size.x=option.get_minimum_size().x+30
	option.status=option.options[str(option.name)]
	$"../../optioncontainer".add_child(option)
	print(%optioncontainer.get_children())
