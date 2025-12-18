extends Tree


func _ready() -> void:
	set_column_title(0,"date")
	set_column_custom_minimum_width(0,100)
	set_column_title(1,"time(1h)")
	set_column_custom_minimum_width(1,30)
	set_column_title(2,"amount(kW)")
	set_column_custom_minimum_width(2,60)
	set_column_title(3,"price(₩)")
	set_column_custom_minimum_width(3,60)
