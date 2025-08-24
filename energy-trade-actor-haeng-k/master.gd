extends Panel


@onready var userbox=load("res://userbox.tscn")

func _ready() -> void:
	var now=Time.get_datetime_string_from_system()

func _on_visibility_changed() -> void:
	if is_visible_in_tree():
		var j = 0
		var flag=true
		for i in len(Global.bid_data):
			while(Global.transaction_bid[i][0]>0):
				if Global.transaction_purchase[j][1]>=Global.transaction_bid[i][1]: #거래 가능 (매칭 성사)
					if Global.transaction_purchase[j][0]>Global.transaction_bid[i][0]:
						Global.matching_result.append([Global.purchase_data[j]["building_id"],Global.bid_data[i]["building_id"],Global.transaction_bid[i][0],(Global.transaction_purchase[j][1]+Global.transaction_bid[i][1])/2])
						Global.transaction_purchase[j][0]-=Global.transaction_bid[i][0]
						Global.transaction_bid[i][0]=0
					elif Global.transaction_purchase[j][0]<=Global.transaction_bid[i][0]:
						Global.matching_result.append([j,i,Global.transaction_purchase[j][0],(Global.transaction_purchase[j][1]+Global.transaction_bid[i][1])/2])
						Global.transaction_bid[i][0]-=Global.transaction_purchase[j][0]
						Global.transaction_purchase[j][0]=0
						j+=1
				else:
					flag=false
					break
			if !flag:
				break
			
		print(Global.matching_result)	
		for i in Global.matching_result:
			var ub=userbox.instantiate()
			ub.naming(i[0],i[1],i[2],i[3])
			%bidContainer.add_child(ub)
			#var ub=userbox.instantiate()
			#ub.custom_minimum_size.y+=20
			#%purchaseContainer.add_child(ub)
		#for i in range(len(Global.purchase_data)):
			#var ub=userbox.instantiate()
			#%bidContainer.add_child(ub)
