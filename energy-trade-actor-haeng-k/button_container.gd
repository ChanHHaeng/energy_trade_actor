extends HBoxContainer

var upperplate:StyleBoxFlat=load("res://assets/upperpanel2.tres")




func _on_buy_button_toggled(toggled_on: bool) -> void:
	%Buy_plate.visible=true
	%Sell_plate.visible=false
	#upperplate.bg_color=Color(0.851,1,1,0.588)
	#upperplate.border_color=Color(0.67,1,1)


func _on_sell_button_toggled(toggled_on: bool) -> void:
	%Buy_plate.visible=false
	%Sell_plate.visible=true
	#upperplate.bg_color=Color(1.0, 0.822, 0.792, 0.488)
	#upperplate.border_color=Color(1,0.76,0.76)
