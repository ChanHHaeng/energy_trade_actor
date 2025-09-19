extends Panel


@onready var size_memory=self.size
@onready var position_memory=self.position

var upposition=Vector2(1,-8)
var downposition=Vector2(63,34)

var upperpnel : StyleBoxFlat =load("res://assets/upperpanel.tres")
var downerpnel:StyleBoxFlat =load("res://assets/downpanel.tres")

var resize_flag=true

func _on_resized() -> void:
	if resize_flag:
		#print(self.size_memory)
		self.position.x=40-((self.size.x)/2)
		if self.global_position.x<80 :
			self.global_position.x=94
		elif self.global_position.x+self.size.x>1080:
			self.global_position.x=1080-self.size.x
		size_memory=self.size
		position_memory=self.position

#func _ready() -> void:
	#print(get_parent().name, " ",resize_flag)
	#circularation(false)
	#print(get_parent().name, ": 2 ",resize_flag)
	

func circularation(flag:bool):
	if !self.visible:
		self.visible=true

	if !flag:
		#print("circulation is ",get_parent().name, "and flag is " , resize_flag)
		$HBoxContainer.visible=false
		$Button.visible=false
		var circling=create_tween()
		#resize_flag=false
		circling.tween_callback(func ():
			resize_flag=false)		
		circling.parallel().tween_property(self,"size",Vector2(17,17),0.25)
		if self.name=="down":
			circling.parallel().tween_property(self,"position",downposition,0.25)
			circling.parallel().tween_property(downerpnel,"corner_radius_top_left",44,0.25)
			circling.parallel().tween_property(downerpnel,"corner_radius_top_right",44,0.25)
			circling.parallel().tween_property(downerpnel,"corner_radius_bottom_left",44,0.25)
			circling.parallel().tween_property(downerpnel,"corner_radius_bottom_right",44,0.25)
		else:
			circling.parallel().tween_property(self,"position",Vector2(0,-8),0.25)
			circling.parallel().tween_property(upperpnel,"corner_radius_top_left",44,0.25)
			circling.parallel().tween_property(upperpnel,"corner_radius_top_right",44,0.25)
			circling.parallel().tween_property(upperpnel,"corner_radius_bottom_left",44,0.25)
			circling.parallel().tween_property(upperpnel,"corner_radius_bottom_right",44,0.25)
		circling.tween_callback(func ():
			#resize_flag=true
			print(get_parent().name, "and", resize_flag)
			self.visible=false)
		#print(resize_flag)
		
	else:
		var squareing=create_tween()
		squareing.tween_callback(func ():
			resize_flag=false)
		resize_flag=false
		squareing.parallel().tween_property(self,"size",size_memory,0.25)
		squareing.parallel().tween_property(self,"position",position_memory,0.25)
		if self.name=="down":
			squareing.parallel().tween_property(downerpnel,"corner_radius_top_left",8,0.25)
			squareing.parallel().tween_property(downerpnel,"corner_radius_top_right",8,0.25)
			squareing.parallel().tween_property(downerpnel,"corner_radius_bottom_left",8,0.25)
			squareing.parallel().tween_property(downerpnel,"corner_radius_bottom_right",8,0.25)
		else:
			squareing.parallel().tween_property(upperpnel,"corner_radius_top_left",8,0.25)
			squareing.parallel().tween_property(upperpnel,"corner_radius_top_right",8,0.25)
			squareing.parallel().tween_property(upperpnel,"corner_radius_bottom_left",8,0.25)
			squareing.parallel().tween_property(upperpnel,"corner_radius_bottom_right",8,0.25)
		squareing.tween_callback(func ():
			resize_flag=true
			$HBoxContainer.visible=true
			$Button.visible=!$Button.disabling)
