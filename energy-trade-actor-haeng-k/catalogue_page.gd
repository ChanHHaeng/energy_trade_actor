extends Panel


func _ready() -> void:
	pass
	


func _on_visibility_changed() -> void:
	if self.visible:
		var purchase_err=$data_searching_buy.request(str(Global.postgrest)+":3000/buy_data")
		var bid_err=$data_searching_sell.request(str(Global.postgrest)+":3000/sell_data")
		%buy.dataset()
		%sell.dataset()
		

	


func _on_data_searching_buy_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var jsontext=body.get_string_from_utf8()
	var results=JSON.parse_string(jsontext)
	Global.buy_data=results.duplicate(true)
	Global.buy_data.sort_custom(sortingdata_buy)
	for i in Global.buy_data:
		Global.transaction_buy[int(i["start_time"])].append([i["buy"],i["price"],int(i["building_id"])])
		
		
		
		
func sortingdata_sell(a,b):
	if a["price"]<b["price"]:
		return true
	elif a["price"]>b["price"]:
		return false
	if a["sell"]>b["sell"]:
		return true
	else:
		return false
		
func sortingdata_buy(a,b):
	if a["price"]<b["price"]:
		return false
	elif a["price"]>b["price"]:
		return true
	if a["buy"]>b["buy"]:
		return true
	else:
		return false


func _on_data_searching_sell_request_completed_sell(result: int, response_code: int,
 headers: PackedStringArray, body: PackedByteArray) -> void:
	var jsontext=body.get_string_from_utf8()
	var results=JSON.parse_string(jsontext)
	Global.sell_data=results.duplicate(true)
	Global.sell_data.sort_custom(sortingdata_sell)
	Global.transaction_clear(1)
	for i in Global.sell_data:
		Global.transaction_sell[int(i["start_time"])].append([i["sell"],i["price"],int(i["building_id"])])	


func _on_data_searching_buy_request_completed_buy(result: int, response_code: int,
 headers: PackedStringArray, body: PackedByteArray) -> void:
	var jsontext=body.get_string_from_utf8()
	var results=JSON.parse_string(jsontext)
	Global.buy_data=results.duplicate(true)
	Global.buy_data.sort_custom(sortingdata_buy)
	Global.transaction_clear(0)
	for i in Global.buy_data:
		Global.transaction_buy[int(i["start_time"])].append([i["buy"],i["price"],int(i["building_id"])])
