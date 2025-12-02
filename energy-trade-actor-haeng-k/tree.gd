extends Tree

enum OpsMode{buy,sell}
@export var ops_mode:OpsMode
#var sorting_column
var root
var onlymine=false
var onlytoday=false
var save=[]

var datebool=true
var idbool=true
var timebool=true
var amountbool=true
var pricebool=true

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
	save.clear()
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
					if !onlymine or int(result["building_id"])==Global.building_id:
						if !onlytoday or result["date"]==Global.date:
							save.append(result)
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




func _on_column_title_clicked(column: int, mouse_button_index: int) -> void:
	if column==0:
		save.sort_custom(sortingdata_date)
		datebool=!datebool
		idbool=true
		timebool=true
		amountbool=true
		pricebool=true
	elif column==1:
		save.sort_custom(sortingdata_building_id)
		idbool=!idbool
		datebool=true
		timebool=true
		amountbool=true
		pricebool=true
	elif column==2:
		save.sort_custom(sortingdata_start_time)
		timebool=!timebool
		datebool=true
		idbool=true
		amountbool=true
		pricebool=true
	elif column==3:
		save.sort_custom(sortingdata_amount)
		amountbool=!amountbool
		datebool=true
		idbool=true
		timebool=true
		pricebool=true
	elif column==4:
		save.sort_custom(sortingdata_price)
		pricebool=!pricebool
		datebool=true
		idbool=true
		timebool=true
		amountbool=true
	clear()
	root=create_item()
	for c in save:
		var item=create_item(root)
		item.set_text(0,c["date"])
		item.set_text(1,str(int(c["building_id"])))
		item.set_text_alignment(1,HORIZONTAL_ALIGNMENT_CENTER)
		item.set_text(2,str(int(c["start_time"])))
		item.set_text_alignment(2,HORIZONTAL_ALIGNMENT_CENTER)
		item.set_text(3,str(int(c[str(self.name)])))
		item.set_text_alignment(3,HORIZONTAL_ALIGNMENT_CENTER)
		item.set_text(4,str(int(c["price"])))
		item.set_text_alignment(4,HORIZONTAL_ALIGNMENT_CENTER)

func sortingdata_date(a,b): ##내림차순
	if date_to_int(a["date"])<date_to_int(b["date"]):
		return datebool
	else:
		return !datebool

func sortingdata_building_id(a,b): ##내림차순
	if int(a["building_id"])<int(b["building_id"]):
		return idbool
	else:
		return !idbool

func sortingdata_start_time(a,b): ##내림차순
	if int(a["start_time"])<int(b["start_time"]):
		return timebool
	else:
		return !timebool

func sortingdata_amount(a,b): ##내림차순
	if int(a[str(self.name)])<int(b[str(self.name)]):
		return amountbool
	else:
		return !amountbool
		
func sortingdata_price(a,b): ##내림차순
	if int(a["price"])<int(b["price"]):
		return pricebool
	else:
		return !pricebool

func date_to_int(date_str: String) -> int:
	return int(date_str.replace("-", ""))
	
#func thetruemaker(some:bool):
	#var saving=some
	#datebool=true
	#idbool=true
	#timebool=true
	#amountbool=true
	#pricebool=true
	#
	#some=!saving
	
	




func _on_item_selected() -> void:
	print("go")
