extends Panel


@onready var userbox=load("res://userbox.tscn")



func _on_visibility_changed() -> void:
	for i in range(len(Global.bid_data)):
		print("1")
		#var ub=userbox.instantiate()
		#%purchaseContainer.add_child(ub)
	#for i in range(len(Global.purchase_data)):
		#var ub=userbox.instantiate()
		#%bidContainer.add_child(ub)
