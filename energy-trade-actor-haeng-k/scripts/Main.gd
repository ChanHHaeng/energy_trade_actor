extends Control

var sell_check
var buy_check

func _ready() -> void:
	print("root")
	$HTTPRequest_buildings.request_completed.connect(_on_building_completed)
	var err_build=$HTTPRequest_buildings.request(str(Global.postgrest)+":3000/buildings")
	%HTTPRequest_buy.request_completed.connect(_buy_completed)
	%HTTPRequest_sell.request_completed.connect(_sell_completed)
	var buy_err=%HTTPRequest_buy.request(str(Global.postgrest)+":3000/buy_data")
	var sell_err=%HTTPRequest_sell.request(str(Global.postgrest)+":3000/sell_data")
	var now=Time.get_datetime_string_from_system()
	print(now)

	
func _on_building_completed(a,b,c,d):
	var jsontext=d.get_string_from_utf8()
	
func _sell_completed(a,b,c,d):
	Global.transaction_clear(1)
	var jsontext=d.get_string_from_utf8()
	var result=JSON.parse_string(jsontext)
	print(result)
	Global.sell_data=result.duplicate(true)
	Global.sell_data.sort_custom(sortingdata_sell)
	for i in Global.sell_data:
		Global.transaction_sell[int(i["start_time"])].append([i["sell"],i["price"],int(i["building_id"])])
	#print("sell is!")
	#print(Global.transaction_sell)
	sell_check=true
	check_all_ready()
	
func _buy_completed(a,b,c,d):
	Global.transaction_clear(0)
	var jsontext=d.get_string_from_utf8()
	var result=JSON.parse_string(jsontext)
	print(result)
	Global.buy_data=result.duplicate(true)
	Global.buy_data.sort_custom(sortingdata_buy)
	for i in Global.buy_data:
		Global.transaction_buy[int(i["start_time"])].append([i["buy"],i["price"],int(i["building_id"])])
	#print("buy is!")
	#print(Global.transaction_buy)
	buy_check=true
	check_all_ready()


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
		

func check_all_ready():
	if buy_check and sell_check:
		$"Panel/Panel/Trade page".setting()
		
func show_warring():
	print("warring!")
	$warring.visible=true
	$warring.modulate.a=1.0
	var tween=create_tween()
	tween.tween_property($warring, "modulate:a",0.0, 1.0)
	tween.tween_callback(onwarring_hidden)

func onwarring_hidden():
	$warring.visible=false
