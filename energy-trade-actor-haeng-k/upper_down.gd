extends Panel


@onready var size_memory=self.size

var resize_flag=true

func _on_resized() -> void:
	if resize_flag:
		print("resized!")
		self.position.x=40-(self.size.x)/2
		size_memory=self.size


func circularation(flag:bool):
	if !flag:
		var circling=create_tween()
		resize_flag=false
		circling.parallel().tween_property(self,"size",Vector2(17,17),0.5)
		circling.parallel().tween_property(self,"position",Vector2(0,-8),0.5)
		circling.finished.connect(func ():
			resize_flag=true)
		
	else:
		var squareing=create_tween()
		resize_flag=false
		squareing.parallel().tween_property(self,"size",Vector2(80,88),0.5)
		squareing.parallel().tween_property(self,"position",Vector2(0,-99),0.5)
		squareing.finished.connect(func ():
			resize_flag=true)
		
