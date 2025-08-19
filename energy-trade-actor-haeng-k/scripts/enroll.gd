extends Button

var timelist
var url
var headers
var body
var body_array=[]
var value_list=[]
var price_list=[]
func _ready() -> void:
	url="http://192.168.0.6:3000/"+name
	headers = [
		"Content-Type: application/json"
	]
	timelist= $"../MenuButton".timelist
	$"../HTTPRequest".request_completed.connect(on_request_completed)

func _on_pressed() -> void:
	for i in timelist:
		var time
		if i<18:
			time=i+6
		else:
			time=i-18
		var index=i
		if i>=12:
			index+=24
		var body
		if get_parent().name=="Bid page":
			body= {
				"date"=Global.date,
				"building_id"=Global.building_id,
				"start_time"=time,
				"bid"=$"../GridContainer".get_child(index+12).text,
				"price"=$"../GridContainer".get_child(index+24).text
			}
		else:
			body= {
				"date"=Global.date,
				"building_id"=Global.building_id,
				"start_time"=time,
				"purchase"=$"../GridContainer".get_child(index+12).text,
				"price"=$"../GridContainer".get_child(index+24).text
			}
		body_array.append(body)
		
	var body_json=JSON.stringify(body_array)
	$"../HTTPRequest".request(url,headers,HTTPClient.METHOD_POST,body_json)
	
	print("timelist is",timelist)
	
	for i in timelist.duplicate():
		print("delete",i)
		get_parent().get_child(0)._on_index_pressed(i)
	print(timelist)
	timelist.clear()
	body_array.clear()
	
	
func on_request_completed(result, response_code, headers, jsonbody):
	print("상태코드",result)
	print("http 상태코드",response_code)
	print("헤더:",headers)
	var bodytext=jsonbody.get_string_from_utf8()
	print(bodytext)
	
func  disabling():
	for i in timelist:
		var index=i
		if i>=12:
			index+=24
		if $"../GridContainer".get_child(index+12).correct_form and $"../GridContainer".get_child(index+24).correct_form:
			pass
		else:
			return
	
	self.disabled=false
			
