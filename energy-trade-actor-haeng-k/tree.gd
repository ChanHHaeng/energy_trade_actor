extends Tree

enum OpsMode{buy,sell}
@export var ops_mode:OpsMode
#var sorting_column
var root
func _ready() -> void:
	set_column_title(0,"date")
	set_column_custom_minimum_width(0,100)
	set_column_title(1,"building_id")
	set_column_custom_minimum_width(1,30)
	set_column_title(2,"time")
	set_column_custom_minimum_width(2,60)
	set_column_title(3,"amount(kw)")
	set_column_custom_minimum_width(3,60)
	set_column_title(4,"price(₩)")
	set_column_custom_minimum_width(4,100)
	y_sort_enabled=true
	
	


func dataset() ->void:
	clear()
	root=create_item()
	var results
	if self.ops_mode==0:
		results=Global.buy_data
	else:
		results=Global.sell_data
	for result in results:
		if (int(result["start_time"]) in %optioncontainer.timeoption) or len(%optioncontainer.timeoption)==0:
			
			if %optioncontainer.value_min<=result[str(self.name)] and result[str(self.name)]<=%optioncontainer.value_max:
				if %optioncontainer.price_min<=result["price"] and result["price"]<=%optioncontainer.price_max:
					var item=create_item(root)
					item.set_text(0,result["date"])
					item.set_text(1,str(int(result["building_id"])))
					item.set_text_alignment(1,HORIZONTAL_ALIGNMENT_CENTER)
					item.set_text(2,str(int(result["start_time"])))
					item.set_text_alignment(2,HORIZONTAL_ALIGNMENT_CENTER)
					item.set_text(3,str(int(result[str(self.name)])))
					item.set_text_alignment(3,HORIZONTAL_ALIGNMENT_CENTER)
					item.set_text(4,str(int(result["price"])))
					item.set_text_alignment(4,HORIZONTAL_ALIGNMENT_CENTER)




#func _on_column_title_clicked(column: int, mouse_button_index: int) -> void:
	#root = get_root()
	#if root == null:
		#return
	#print(root)
	#var children = root.get_children()
	#var comparater=Callable(self,"compare_item").bind(column)
	#children.sort_custom(comparater)
	#
	#clear()
	#root=create_item()
	#for c in children:
		#var item=create_item(root)
		#item.set_text(0,c["date"])
		#item.set_text(1,str(int(c["building_id"])))
		#item.set_text_alignment(1,HORIZONTAL_ALIGNMENT_CENTER)
		#item.set_text(2,str(int(c["start_time"])))
		#item.set_text_alignment(2,HORIZONTAL_ALIGNMENT_CENTER)
		#item.set_text(3,str(c[str(self.name)]))
		#item.set_text_alignment(3,HORIZONTAL_ALIGNMENT_CENTER)
		#item.set_text(4,str(c["price"]))
		#item.set_text_alignment(4,HORIZONTAL_ALIGNMENT_CENTER)
#
#func compare_item(a:TreeItem,b:TreeItem,column:int):
	#var a_text=a.get_text(column)
	#var b_text=b.get_text(column)
	#return a_text<b_text
	
	
