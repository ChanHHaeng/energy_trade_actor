extends Panel


func _ready() -> void:
	pass
	


func _on_visibility_changed() -> void:
	if self.visible:
		print("gogogo!")
		var purchase_err=$data_searching_buy.request(str(Global.postgrest)+":3000/buy_data")
		var bid_err=$data_searching_sell.request(str(Global.postgrest)+":3000/sell_data")
		

	
