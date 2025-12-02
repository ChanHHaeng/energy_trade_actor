extends Tree


var save=[]
var root

func _ready() -> void:
	set_column_title(0,"date")
	set_column_custom_minimum_width(0,100)
	set_column_title(1,"time")
	set_column_custom_minimum_width(1,30)
	set_column_title(2,"amount(kw)")
	set_column_custom_minimum_width(2,60)
	set_column_title(3,"price(₩)")
	set_column_custom_minimum_width(3,60)
	set_column_title(4,"From")
	set_column_custom_minimum_width(4,100)
	set_column_title(5,"To")
	set_column_custom_minimum_width(5,100)
	y_sort_enabled=true


func dataset() ->void:
	clear()
	save.clear()
	root=create_item()
	for result in Global.matching_result:
		var item=create_item(root)
		for i in range(6):
			item.set_text(i,str(result[i]))
			item.set_text_alignment(i,HORIZONTAL_ALIGNMENT_CENTER)
	
	
	for result in Global.matching_result:
		var datemenu:PopupMenu= $Popups.get_child(0)
		var dupliflag=false
		for i in range(datemenu.item_count):
			if datemenu.get_item_text(i)==result[0]:
				dupliflag=true
				break
		if !dupliflag:
			datemenu.add_item(result[0])
		
		


func _on_column_title_clicked(column: int, _mouse_button_index: int) -> void:
	$Popups.get_child(column).popup_centered()
	#$PopupMenu.popup_centered()
