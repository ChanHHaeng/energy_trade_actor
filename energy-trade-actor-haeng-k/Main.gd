extends Control


func _ready():
	
	$HTTPRequest_import.request_completed.connect(_on_import_completed)
	$HTTPRequest_export.request_completed.connect(_on_export_completed)
	$HTTPRequest_buildings.request_completed.connect(_on_building_completed)
	var err_build=$HTTPRequest_buildings.request("http://192.168.0.6:3000/buildings")
	var err=$HTTPRequest_import.request("http://192.168.0.6:3000/import_data")
	var err2=$HTTPRequest_export.request("http://192.168.0.6:3000/export_data")
	
	

func _on_import_completed(a,b,c,d):
	var jsontext=d.get_string_from_utf8()
	var parse_result=JSON.parse_string(jsontext)
	
	for i in parse_result:
		print(i)
		#Global.import_data.append(i)
	
func _on_export_completed(a,b,c,d):
	var jsontext=d.get_string_from_utf8()
	print(jsontext)
	
	
func _on_building_completed(a,b,c,d):
	var jsontext=d.get_string_from_utf8()
	print(jsontext)
