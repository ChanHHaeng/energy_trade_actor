extends Panel


func _ready() -> void:
	%HTTPRequest_purchase.request_completed.connect(_purchase_completed)
	%HTTPRequest_bid.request_completed.connect(_bid_completed)


func _on_visibility_changed() -> void:
	if self.visible and Global.building_id==0:
		$Master.visible=true
	elif self. visible:
		$User.visible=true
	else:
		$Master.visible=false
		$User.visible=false
		
		
	if self.visible:
		var purchase_err=$"../../../HTTPRequest_purchase".request("http://192.168.0.6:3000/purchase_data")
		var bid_err=$"../../../HTTPRequest_bid".request("http://192.168.0.6:3000/bid_data")

func _bid_completed(a,b,c,d):
	var jsontext=d.get_string_from_utf8()
	var result=JSON.parse_string(jsontext)
	Global.bid_data=result.duplicate(true)
	#$Bidpage_sect/bid.dataset()
	
func _purchase_completed(a,b,c,d):
	var jsontext=d.get_string_from_utf8()
	var result=JSON.parse_string(jsontext)
	Global.purchase_data=result.duplicate(true)
	#$Purchase_sect/purchase.dataset()
