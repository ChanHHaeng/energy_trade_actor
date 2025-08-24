extends Panel

var purcheck=false
var bidcheck=false

func _ready() -> void:
	pass


func _on_visibility_changed() -> void:	
	if is_visible_in_tree():
		%HTTPRequest_purchase.request_completed.connect(_purchase_completed)
		%HTTPRequest_bid.request_completed.connect(_bid_completed)
		var purchase_err=%HTTPRequest_purchase.request("http://192.168.0.6:3000/purchase_data")
		var bid_err=%HTTPRequest_bid.request("http://192.168.0.6:3000/bid_data")



func _bid_completed(a,b,c,d):
	Global.transaction_bid.clear()
	var jsontext=d.get_string_from_utf8()
	var result=JSON.parse_string(jsontext)
	Global.bid_data=result.duplicate(true)
	Global.bid_data.sort_custom(sortingdata_bid)
	for i in Global.bid_data:
		Global.transaction_bid.append([i["bid"],i["price"]])
	print(Global.bid_data)
	bidcheck=true
	check_all_ready()
	
func _purchase_completed(a,b,c,d):
	Global.transaction_purchase.clear()
	var jsontext=d.get_string_from_utf8()
	var result=JSON.parse_string(jsontext)
	Global.purchase_data=result.duplicate(true)
	Global.purchase_data.sort_custom(sortingdata_pur)
	for i in Global.purchase_data:
		Global.transaction_purchase.append([i["purchase"],i["price"]])
	print(Global.purchase_data)
	purcheck=true
	check_all_ready()

func check_all_ready():
	if purcheck and bidcheck:
		if self.visible and Global.building_id==0:
			$User.visible=false
			$Master.visible=true
		elif self. visible:
			$User.visible=true
			$Master.visible=false
		else:
			$Master.visible=false
		$User.visible=false
		purcheck=false
		bidcheck=false
		
func sortingdata_bid(a,b):
	if a["price"]<b["price"]:
		return true
	elif a["price"]>b["price"]:
		return false
	if a["bid"]>b["bid"]:
		return true
	else:
		return false
		
func sortingdata_pur(a,b):
	if a["price"]<b["price"]:
		return false
	elif a["price"]>b["price"]:
		return true
	if a["bid"]>b["bid"]:
		return true
	else:
		return false
