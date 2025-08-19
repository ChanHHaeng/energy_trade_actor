extends MenuButton

@onready var glass=load("res://themes/greenglass.tres")
@onready var optionscene=load("res://option.tscn")

func _ready() -> void:
	get_popup().max_size.y=150
	get_popup().add_theme_stylebox_override('panel',glass)
	get_popup().connect("index_pressed", Callable(self, "_on_index_pressed"))
	get_popup().hide_on_checkable_item_selection = false
	
func _on_index_pressed(index: int) -> void:
	get_popup().set_item_checked(index, !get_popup().is_item_checked(index))
	if get_popup().is_item_checked(index):
		var option=optionscene.instantiate()
		option.text="  "+get_popup().get_item_text(index)
		option.name=get_popup().get_item_text(index)
		option.custom_minimum_size.x=option.get_minimum_size().x+30
		option.status=0
		$"../optioncontainer".add_child(option)
	elif !get_popup().is_item_checked(index):
		#$"../optioncontainer".get_node(get_popup().get_item_text(index)).queue_free()
		var nodename=get_popup().get_item_text(index)
		nodename= nodename.replace(":","_")
		print(nodename)
		print($"../optioncontainer".get_node(nodename))
		$"../optioncontainer".get_node(nodename).queue_free()

func _on_optioncontainer_child_exiting_tree(node: Node) -> void:
	get_popup().set_item_checked(Global.TimeSlots.find(node.name),false)
