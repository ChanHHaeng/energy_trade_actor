extends Panel


func _ready() -> void:
	pass
	#visibility_changed.connect(dataset)
	#
	#
	#
	#
#func dataset():
	#print("go")


#func _on_visibility_changed() -> void:
	#if self.visible:
		#$"../../../HTTPRequest_purchase".request_completed.connect(_purchase_completed)
		#$"../../../HTTPRequest_bid".request_completed.connect(_bid_completed)
		#var purchase_err=$"../../../HTTPRequest_purchase".request(str(Global.postgrest)+":3000/purchase_data")
		#var bid_err=$"../../../HTTPRequest_bid".request(str(Global.postgrest)+":3000/bid_data")
		
		
		
func _bid_completed(a,b,c,d):
	#print("gogo")
	var jsontext=d.get_string_from_utf8()
	var result=JSON.parse_string(jsontext)
	Global.bid_data=result.duplicate(true)
	$Bidpage_sect/bid.dataset()
	
func _purchase_completed(a,b,c,d):
	var jsontext=d.get_string_from_utf8()
	var result=JSON.parse_string(jsontext)
	Global.purchase_data=result.duplicate(true)
	$Purchase_sect/purchase.dataset()
	
