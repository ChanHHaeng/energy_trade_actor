extends HBoxContainer






func _on_buy_button_toggled(toggled_on: bool) -> void:
	$"../Buy_plate".visible=true
	$"../Sell_plate".visible=false



func _on_sell_button_toggled(toggled_on: bool) -> void:
	$"../Buy_plate".visible=false
	$"../Sell_plate".visible=true
