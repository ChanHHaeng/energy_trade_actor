extends Panel


@onready var userbox=load("res://userbox.tscn")

func _ready() -> void:
	var now=Time.get_datetime_string_from_system()

func _on_visibility_changed() -> void:
	if is_visible_in_tree():
		Global.matching_result.clear()
		var flag=true
		for k in range(24): #시간별 탐색
			var j = 0 # j:purchase 전용 단위
			if len(Global.transaction_purchase[k])>0 and len(Global.transaction_bid[k])>0: #거래 가능 여부 확인
				#print("time is", k)
				#print(Global.transaction_purchase[k])
				#print(Global.transaction_bid[k])
				for i in len(Global.transaction_bid[k]):
					while(Global.transaction_bid[k][i][0]>0): 
						#print("time:", k)
						#print("ireguller",Global.transaction_purchase[k])
						#print("value: ", Global.transaction_purchase[k][j][1])
						#print("and ",Global.transaction_bid[k][i][1])
						if Global.transaction_purchase[k][j][1]>=Global.transaction_bid[k][i][1]: #거래 가능 (매칭 성사)
							if Global.transaction_purchase[k][j][0]>Global.transaction_bid[k][i][0]:
								Global.matching_result.append([Global.transaction_purchase[k][j][2],Global.transaction_bid[k][i][2],Global.transaction_bid[k][i][0],(Global.transaction_purchase[k][j][1]+Global.transaction_bid[k][i][1])/2,k])
								Global.transaction_purchase[k][j][0]-=Global.transaction_bid[k][i][0]
								Global.transaction_bid[k][i][0]=0
							elif Global.transaction_purchase[k][j][0]<=Global.transaction_bid[k][i][0]:
								Global.matching_result.append([j,i,Global.transaction_purchase[k][j][0],(Global.transaction_purchase[k][j][1]+Global.transaction_bid[k][i][1])/2,k])
								Global.transaction_bid[k][i][0]-=Global.transaction_purchase[k][j][0]
								Global.transaction_purchase[k][j][0]=0
								j+=1
						else:
							flag=false
							break
					if !flag:
						break
			
		print(Global.matching_result)
		for i in %bidContainer.get_children():
			i.queue_free()
			
		for i in Global.matching_result:
			var ub=userbox.instantiate()
			ub.naming(i[0],i[1],i[2],i[3],i[4])
			%bidContainer.add_child(ub)
			#var ub=userbox.instantiate()
			#ub.custom_minimum_size.y+=20
			#%purchaseContainer.add_child(ub)
		#for i in range(len(Global.purchase_data)):
			#var ub=userbox.instantiate()
			#%bidContainer.add_child(ub)
