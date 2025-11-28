extends Button

enum page{Trade,Catalogue,MyPage}
@export var page_num:page
#@export var hover_scale: Vector2 = Vector2(1.08, 1.08)
#@export var pressed_scale: Vector2 = Vector2(0.93, 0.87)
#@export var tween_time: float = 0.12
@onready var core=get_node("../../Core")

func _ready() -> void:
	if Global.building_id==0 and name=="My Page":
		print("heeeeeeeeeeeeeeeeeeeeee?")
		self.text="master 📄"
	
func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		core.change_window(core.nowpage,self.page_num)
		core.nowpage=self.page_num
		var tween=create_tween()
		%menu_plate.position.x=self.page_num*364
		%menu_plate.origin.x=self.page_num*364
		self.disabled=true
	else:
		self.disabled=false




func _on_mouse_entered() -> void:
	var menu_tween=create_tween()
	menu_tween.tween_property(%menu_plate,"position",Vector2(364*self.page_num,0),0.3)


func _on_mouse_exited() -> void:
	var menu_tween=create_tween()
	menu_tween.tween_property(%menu_plate,"position",Vector2(364*core.nowpage,0),0.3)
