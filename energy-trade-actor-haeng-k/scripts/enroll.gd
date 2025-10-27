extends Button

var timetable
var buy_url
var sell_url
var headers
var body
var body_array=[]
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
	$"../data_sending".request_completed.connect(on_request_completed)
	print($"..".get("timetable"))

func _on_pressed() -> void:
	for i in $"../GridContainer".get_children():
		#i.name
		i.gain_data()
	for i in $"../GridContainer2".get_children():
		i.gain_data()
	
	#pretable=$"..".timetable
	#for j in range(12):
		#get_node("../GridContainer").get_child(j).name
	
		#var time
		#if i<18:
			#time=i+6
		#else:
			#time=i-18
		#var index=i
		#if i>=12:
			#index+=24
		#var body
		#if get_parent().name=="Bid page":
			#body= {
				#"date"=Global.date,
				#"building_id"=Global.building_id,
				#"start_time"=time,
				#"buy"=$"../GridContainer".get_child(index+12).text,
				#"price"=$"../GridContainer".get_child(index+24).text
			#}
		#else:
			#body= {
				#"date"=Global.date,
				#"building_id"=Global.building_id,
				#"start_time"=time,
				#"purchase"=$"../GridContainer".get_child(index+12).text,
				#"price"=$"../GridContainer".get_child(index+24).text
			#}
		#body_array.append(body)
		#
	#var body_json=JSON.stringify(body_array)
	#%HTTPRequest_buy.request(buy_url,headers,HTTPClient.METHOD_POST,body_json)
	#%HTTPRequest_sell.request(sell_url,headers,HTTPClient.METHOD_POST,body_json)
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
			
