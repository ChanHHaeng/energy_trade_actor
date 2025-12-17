extends Button

var headers
var Bodyjson
var response_body_instance
signal record_completed
func _ready() -> void:
	headers = [
		"Content-Type: application/json"
	]


func _on_login_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	#print("result is ")
	#print(result)
	#print("respose_code is")
	#print(response_code)
	
	#print("headers is")
	#print(headers)
	#print("body is")
	#print(body.get_string_from_utf8())
	response_body_instance=JSON.parse_string(body.get_string_from_utf8()) 
	emit_signal("record_completed")

func _on_pressed() -> void:
	var Body = {
		"username" = %username.text,
		"Password" = %Password.text
	}
	Bodyjson=JSON.stringify(Body)
	var _err_login=$"../login_request".request\
	(str(Global.postgrest)+":3000/account?username=eq."+%username.text+"&password_hash=eq."+%Password.text,headers,HTTPClient.METHOD_GET)
	await record_completed
	print(response_body_instance)
	
	if len(response_body_instance)==1:##로그인 성공 이후 기점
		Global.building_id=int(response_body_instance[0]["building_id"])
		get_owner().certification()
