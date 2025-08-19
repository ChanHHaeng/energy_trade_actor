extends Tree


func _ready() -> void:
	set_column_title(0,"date")
	set_column_title(1,"building_id")
	set_column_title(2,"time")
	set_column_title(3,"amount")
	set_column_title(4,"price")
	
	#root=create_item()
	
	


func dataset() ->void:
	clear()
	var root=create_item()
	var results
	if self.name=="purchase":
		results=Global.purchase_data
	else:
		results=Global.bid_data
	for result in results:
		if (int(result["start_time"]) in %optioncontainer.timeoption) or len(%optioncontainer.timeoption)==0:
			if %optioncontainer.value_min<=result[str(self.name)] and result[str(self.name)]<=%optioncontainer.value_max:
				if %optioncontainer.price_min<=result["price"] and result["price"]<=%optioncontainer.price_max:
					var item=create_item(root)
					item.set_text(0,result["date"])
					item.set_text(1,str(result["building_id"]))
					item.set_text(2,str(int(result["start_time"])))
					item.set_text(3,str(result[str(self.name)]))
					item.set_text(4,str(result["price"]))
