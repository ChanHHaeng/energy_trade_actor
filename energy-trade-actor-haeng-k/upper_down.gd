extends Panel

enum OpsMode{Upper, Down}

@export var ops_mode: OpsMode = OpsMode.Upper
@onready var size_memory=self.size
@onready var position_memory=self.position

var upposition=Vector2(448,250)
var downposition=Vector2(448,34)

var upperpnel : StyleBoxFlat =load("res://assets/upperpanel.tres")
var downerpnel:StyleBoxFlat =load("res://assets/downpanel.tres")

var resize_flag=true


func _ready() -> void:
	##초기에 사이즈 작아지게 하는 코드
	if ops_mode==1:
		await get_tree().process_frame
		self.position=get_node("../..").global_position+Vector2(0,60)
		position_memory=self.position
		position_memory.x= (get_viewport_rect().size.x / 2)-(self.size.x/2)
		position_memory.y=400
		downposition=get_node("../..").global_position+Vector2(70,40)
	
	else:
		await get_tree().process_frame
		self.position=get_node("../..").global_position-Vector2(0,210)
		position_memory=self.position
		position_memory.x= (get_viewport_rect().size.x / 2)-(self.size.x/2)
		position_memory.y=100
		upposition=get_node("../..").global_position
		
	resize_flag=false ##내부 설정
	self.size=Vector2(17,17)
	if ops_mode==1:
		self.position=downposition
	elif ops_mode==0:
		self.position=upposition
	$HBoxContainer.visible=false
	$Button.visible=false
	$TextureRect.visible=false
	resize_flag=true
	
	
func _on_resized() -> void:
	 ##체크 지점
	if resize_flag:
		print("resized!")
		size_memory=self.size
		#if len($HBoxContainer.get_children())==0:
			#set_zero()
		position.x= (get_viewport_rect().size.x / 2)-(self.size.x/2)
		if ops_mode==0:
			position.y=100
		else:
			position.y=400
		position_memory=self.position
			
func circularation(flag:bool):
	if !self.visible:
		self.visible=true

	if !flag:
		$HBoxContainer.visible=false
		$Button.visible=false
		$TextureRect.visible=false
		await get_tree().process_frame
		var circling=create_tween()
		circling.tween_callback(func ():
			resize_flag=false)		
		circling.parallel().tween_property(self,"size",Vector2(17,17),0.25)
		if self.name=="down":
			circling.parallel().tween_property(self,"position",downposition,0.25)
			#circling.parallel().tween_property(downerpnel,"corner_radius_top_left",44,0.25)
			#circling.parallel().tween_property(downerpnel,"corner_radius_top_right",44,0.25)
			#circling.parallel().tween_property(downerpnel,"corner_radius_bottom_left",44,0.25)
			#circling.parallel().tween_property(downerpnel,"corner_radius_bottom_right",44,0.25)
		else:
			circling.parallel().tween_property(self,"position",upposition,0.25)
			#circling.parallel().tween_property(upperpnel,"corner_radius_top_left",44,0.25)
			#circling.parallel().tween_property(upperpnel,"corner_radius_top_right",44,0.25)
			#circling.parallel().tween_property(upperpnel,"corner_radius_bottom_left",44,0.25)
			#circling.parallel().tween_property(upperpnel,"corner_radius_bottom_right",44,0.25)
		circling.tween_callback(func ():
			self.visible=false
			)
		
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
			if len($HBoxContainer.get_children())<5:
				$Button.visible=true
			else:
				$Button.visible=!$Button.disabling
			$TextureRect.visible=true
			)
			
func get_data() -> Array:
	var dish=[]
	for i in get_child(0).get_children():
		dish.append([int(i.amount),int(i.price)])
	return dish


#func set_zero():
	#if ops_mode==1:
		#await get_tree().process_frame
		#self.position=get_node("../..").global_position+Vector2(0,70)
		#position_memory=self.position
		#downposition=get_node("../..").global_position+Vector2(70,40)
	#
	#else:
		#await get_tree().process_frame
		#self.position=get_node("../..").global_position-Vector2(0,200)
		#position_memory=self.position
		#upposition=get_node("../..").global_position
