extends PopupMenu

enum state{date,
time,
amount,
price,
from,
to}


@export var status:state
func _on_index_pressed(index: int) -> void:
	set_item_checked(index, !is_item_checked(index))
	if is_item_checked(index):
		%"Master tree".fullcond[status].append(get_item_text(index))
	elif !is_item_checked(index):
		%"Master tree".fullcond[status].erase(get_item_text(index))
	%"Master tree".dataset()
	
func _ready() -> void:
	if status==1:
		for i in range(24):
			add_item("%d" %i)
			set_item_as_checkable(-1,true)
