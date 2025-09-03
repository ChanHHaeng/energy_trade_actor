@tool
extends GridContainer

@onready var timer=load("res://timer.tscn")

#func _ready() -> void:
	#for i in range(12):
		#var childs=timer.instantiate()
		#childs.text=("%02d:00" %[i,])
		#childs.name=str(i+6)
		#self.add_child(childs)
		#childs.owner=get_tree().edited_scene_root
