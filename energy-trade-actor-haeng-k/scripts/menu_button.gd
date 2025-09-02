#@tool
extends MenuButton

@onready var glass=load("res://themes/greenglass.tres")
@onready var unselected=load("res://themes/unselected_cell.tres")
@onready var selected=load("res://themes/selected_cell.tres")
@onready var unselected_label=load("res://themes/unselected_label.tres")
@onready var selected_label=load("res://themes/selected_label.tres")

var timelist=[]
var time_amountlist
var time_pricelist
func _ready() -> void:
	#if Engine.is_editor_hint():
		#get_popup().clear()
		#for i in range(24):
			#var hour = (6 + i) % 24
			#var label = "%02d:00 ~ %02d:00" % [hour, hour + 1]
			#get_popup().add_check_item(label)
	get_popup().max_size.y=150
	get_popup().add_theme_stylebox_override('panel',glass)
	get_popup().add_theme_stylebox_override('hover',glass)
	get_popup().connect("index_pressed", Callable(self, "_on_index_pressed"))
	get_popup().hide_on_checkable_item_selection = false
	


func _on_index_pressed(index: int) -> void:
	get_popup().set_item_checked(index, !get_popup().is_item_checked(index))
	if index<12:
		if get_popup().is_item_checked(index):
			$"../GridContainer".get_child(index).add_theme_color_override('font_color',Color.BLACK)
			$"../GridContainer".get_child(index).add_theme_stylebox_override("normal",selected_label)
			$"../GridContainer".get_child(index+12).theme=selected
			$"../GridContainer".get_child(index+12).placeholder_text="amount"
			$"../GridContainer".get_child(index+12).editable=true
			$"../GridContainer".get_child(index+24).theme=selected
			$"../GridContainer".get_child(index+24).placeholder_text="price"
			$"../GridContainer".get_child(index+24).editable=true
			timelist.append(index)
			
		else:
			$"../GridContainer".get_child(index).add_theme_color_override('font_color',Color.GRAY)
			$"../GridContainer".get_child(index).add_theme_stylebox_override("normal",unselected_label)
			$"../GridContainer".get_child(index+12).theme=unselected
			$"../GridContainer".get_child(index+12).placeholder_text=""
			$"../GridContainer".get_child(index+12).text=""
			$"../GridContainer".get_child(index+12).editable=false
			$"../GridContainer".get_child(index+24).theme=unselected
			$"../GridContainer".get_child(index+24).placeholder_text=""
			$"../GridContainer".get_child(index+24).text=""
			$"../GridContainer".get_child(index+24).editable=false
			timelist.erase(index)
	else:
		if get_popup().is_item_checked(index):
			$"../GridContainer".get_child(index+24).add_theme_color_override('font_color',Color.BLACK)
			$"../GridContainer".get_child(index+24).add_theme_stylebox_override("normal",selected_label)
			$"../GridContainer".get_child(index+36).theme=selected
			$"../GridContainer".get_child(index+36).placeholder_text="amount"
			$"../GridContainer".get_child(index+36).editable=true
			$"../GridContainer".get_child(index+48).theme=selected
			$"../GridContainer".get_child(index+48).placeholder_text="price"
			$"../GridContainer".get_child(index+48).editable=true
			timelist.append(index)
		else:
			$"../GridContainer".get_child(index+24).add_theme_color_override('font_color',Color.GRAY)
			$"../GridContainer".get_child(index+24).add_theme_stylebox_override("normal",unselected_label)
			$"../GridContainer".get_child(index+36).theme=unselected
			$"../GridContainer".get_child(index+36).placeholder_text=""
			$"../GridContainer".get_child(index+36).text=""
			$"../GridContainer".get_child(index+36).editable=false
			$"../GridContainer".get_child(index+48).theme=unselected
			$"../GridContainer".get_child(index+48).placeholder_text=""
			$"../GridContainer".get_child(index+48).text=""
			$"../GridContainer".get_child(index+48).editable=false
			timelist.erase(index)
	
