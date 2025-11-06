extends Button

var timetable
var buy_url
var sell_url
var headers
var body
var body_array_buy=[]
var body_array_sell=[]
var body_array_del=[]
var value_list=[]
var price_list=[]


var pretable
var newtable={
	6: [[], []],
	7: [[], []],
	8: [[], []],
	9: [[], []],
	10: [[], []],
	11: [[], []],
	12: [[], []],
	13: [[], []],
	14: [[], []],
	15: [[], []],
	16: [[], []],
	17: [[], []],
	18: [[], []],
	19: [[], []],
	20: [[], []],
	21: [[], []],
	22: [[], []],
	23: [[], []],
	0: [[], []],
	1: [[], []],
	2: [[], []],
	3: [[], []],
	4: [[], []],
	5: [[], []],
}

func _ready() -> void:
	buy_url=Global.postgrest+":3000/buy_data"
	sell_url=Global.postgrest+":3000/sell_data"
	headers = [
		"Content-Type: application/json"
	]
	
	%data_sending_buy.request_completed.connect(on_request_completed)
	%data_sending_sell.request_completed.connect(on_request_completed)
	%data_removing_buy.request_completed.connect(on_request_del_completed)
	%data_removing_sell.request_completed.connect(on_request_del_completed)
	print($"..".get("timetable"))

func _on_pressed() -> void:
	#if $"../../../../enrolling".show_select() :
		#pass
	#else:
		#return
	newtable=$"..".timetable.duplicate(true)
	var instance_table={}
	for i in $"../GridContainer".get_children():
		instance_table[int(i.name)]=i.gain_data()
	for i in $"../GridContainer2".get_children():
		instance_table[int(i.name)]=i.gain_data()
	var focus=compare_table(instance_table)
	var focus_str=",".join(PackedStringArray(focus.keys()))
	print(focus_str)
	
	var new_buy_url=buy_url+("?building_id=eq.%d&start_time=in.(%s)" % [Global.building_id, focus_str])
	var new_sell_url=sell_url+("?building_id=eq.%d&start_time=in.(%s)" % [Global.building_id, focus_str])
	
	var body_json_del=JSON.stringify(body_array_del)
	%data_removing_buy.request(new_buy_url,headers,HTTPClient.METHOD_DELETE)
	%data_removing_sell.request(new_sell_url,headers,HTTPClient.METHOD_DELETE)
	
	
	for i in focus:
		
		##삽입 부분 
		var sector=focus[i]
		for j in sector[0]:
			var body
			body = {
				"date"=Global.date,
				"building_id"=Global.building_id,
				"start_time"=i,
				"buy"=j[0],
				"price"=j[1]
			}
			body_array_buy.append(body)
			
			
		for j in sector[1]:
			var body
			body = {
				"date"=Global.date,
				"building_id"=Global.building_id,
				"start_time"=i,
				"sell"=j[0],
				"price"=j[1]
			}
			body_array_sell.append(body)
		#
	var body_json_buy=JSON.stringify(body_array_buy)
	var body_json_sell=JSON.stringify(body_array_sell)
	%data_sending_buy.request(buy_url,headers,HTTPClient.METHOD_POST,body_json_buy)
	%data_sending_sell.request(sell_url,headers,HTTPClient.METHOD_POST,body_json_sell)
	#
	#for i in timelist.duplicate():
		#print("delete",i)
		#get_parent().get_child(0)._on_index_pressed(i)
	#print(timelist)
	#timelist.clear()
	#body_array.clear()
	
	
func on_request_completed(result, response_code, headers, jsonbody):
	print("상태코드",result)
	print("http 상태코드",response_code)
	print("헤더:",headers)
	var bodytext=jsonbody.get_string_from_utf8()
	print(bodytext)

func on_request_del_completed(result, response_code, headers, jsonbody):
	print("del succiied!")
	print("상태코드",result)
	print("http 상태코드",response_code)
	print("헤더:",headers)
	var bodytext=jsonbody.get_string_from_utf8()
	print(bodytext)
#func  disabling():
	#for i in timelist:
		#var index=i
		#if i>=12:
			#index+=24
		#if $"../GridContainer".get_child(index+12).correct_form and $"../GridContainer".get_child(index+24).correct_form:
			#pass
		#else:
			#self.disabled=true
			#return
	#
	#self.disabled=false
			

func compare_table(instance_table:Dictionary) ->Dictionary:
	var bowl={}
	for i in range(24):
		if instance_table[i]!=newtable[i]: #변화 부분 발견
			bowl[i]=instance_table[i]
	
	return bowl
	
