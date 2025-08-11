extends Button

var timelist
var url
var headers
var body
var body_array=[]
func _ready() -> void:
	url="http://192.168.0.6:3000/export_data"
	headers = [
		"Content-Type: application/json"
	]
	timelist= $"../MenuButton".timelist


func _on_pressed() -> void:
	#print(timelist)
	for i in timelist:
		var time
		if i<18:
			time=i+6
		else:
			time=i-18
		var index=i
		if i>=12:
			index+24
		var body= {
			"date"=Global.date,
			"building_id"=Global.building_id,
			"start_time"=time,
			"bid"=$"../GridContainer".get_child(index+12),
			"value"=$"../GridContainer".get_child(index+24)
		}
		body_array.append(body)
	
	print(body_array)
		
	
	pass # Replace with function body.
	
	
func data_enroll():
	pass
