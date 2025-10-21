extends Panel


@onready var size_memory=self.size
@onready var position_memory=self.position

var upposition=Vector2(448,250)
var downposition=Vector2(448,34)

var upperpnel : StyleBoxFlat =load("res://assets/upperpanel.tres")
var downerpnel:StyleBoxFlat =load("res://assets/downpanel.tres")

var resize_flag=true


func _ready() -> void:
	if self.name=="down":
		await get_tree().process_frame
		self.position=get_node("../..").global_position+Vector2(0,70)
		position_memory=self.position
		downposition=get_node("../..").global_position+Vector2(70,40)
		
	else:
		await get_tree().process_frame
		self.position=get_node("../..").global_position-Vector2(0,200)
		position_memory=self.position
		upposition=get_node("../..").global_position
	
	resize_flag=false ##내부 설정
	self.size=Vector2(17,17)
	if self.name=="down":
		self.position=downposition
	else:
		self.position=upposition
	$HBoxContainer.visible=false
	$Button.visible=false
	resize_flag=true
	
	
func _on_resized() -> void:
	 ##체크 지점
	
	if resize_flag:
		if get_owner().name=="7":
			print("size changed! :", self.size)
		size_memory=self.size
		position_memory=self.position

func circularation(flag:bool):
	if !self.visible:
		self.visible=true

	if !flag:
		$HBoxContainer.visible=false
		$Button.visible=false
		var circling=create_tween()
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
			circling.parallel().tween_property(self,"position",upposition,0.25)
			circling.parallel().tween_property(upperpnel,"corner_radius_top_left",44,0.25)
			circling.parallel().tween_property(upperpnel,"corner_radius_top_right",44,0.25)
			circling.parallel().tween_property(upperpnel,"corner_radius_bottom_left",44,0.25)
			circling.parallel().tween_property(upperpnel,"corner_radius_bottom_right",44,0.25)
		circling.tween_callback(func ():
			self.visible=false
			)
		
	else:
		print("squaring!")
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
