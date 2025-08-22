extends Panel


@onready var userbox=load("res://userbox.tscn")

func _ready() -> void:
	var now=Time.get_datetime_string_from_system()

func _on_visibility_changed() -> void:
	if is_visible_in_tree():
		for i in Global.bid_data:
			var ub=userbox.instantiate()
			ub.custom_minimum_size.y+=20
			%purchaseContainer.add_child(ub)
		for i in range(len(Global.purchase_data)):
			var ub=userbox.instantiate()
			%bidContainer.add_child(ub)
