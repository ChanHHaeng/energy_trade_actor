extends MenuButton

@onready var glass=load("res://themes/greenglass.tres")
@onready var optionscene=load("res://option.tscn")


func _ready() -> void:
	get_popup().max_size.y=150
	get_popup().add_theme_stylebox_override('panel',glass)
	get_popup().connect("index_pressed", Callable(self, "_on_index_pressed"))
	get_popup().hide_on_checkable_item_selection = false


func _on_index_pressed(index: int) -> void:
	var count=get_popup().item_count
	for i in range(count):
		get_popup().set_item_checked(i,false)
	get_popup().set_item_checked(index, !get_popup().is_item_checked(index))
	var time
	if index<18:
		time=index+6
	else:
		time=index-18
	for i in %bidContainer.get_children():
		if i.time==time:
			i.visible=true
		else:
			i.visible=false
