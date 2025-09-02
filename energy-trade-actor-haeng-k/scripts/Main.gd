extends Control


func _ready():
	$HTTPRequest_buildings.request_completed.connect(_on_building_completed)
	var err_build=$HTTPRequest_buildings.request(str(Global.postgrest)+":3000/buildings")
	var now=Time.get_datetime_string_from_system()
	print(now)

	
func _on_building_completed(a,b,c,d):
	var jsontext=d.get_string_from_utf8()
	#print(jsontext)
