@tool
extends GridContainer

@onready var timer=load("res://timer.tscn")

func _ready() -> void:
	for i in range(12):
		var num
		if i<6:
			num=i+18
		else:
			num=i-6
		var childs=timer.instantiate()
		childs.text=("%02d:00" %[num])
		childs.name=str(num)
		self.add_child(childs)
		childs.owner=get_tree().edited_scene_root
