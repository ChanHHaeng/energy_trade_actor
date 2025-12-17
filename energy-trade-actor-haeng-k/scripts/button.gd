extends Button

enum page{Trade,Catalogue,MyPage}
@export var page_num:page
@onready var core=get_node("../../Core")

var mouse_inside=false
func _ready() -> void:
	if Global.building_id==0 and name=="My Page":
		print("heeeeeeeeeeeeeeeeeeeeee?")
		self.text="Master"

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		core.change_window(core.nowpage,self.page_num)
		core.nowpage=self.page_num
		core.activate_window(page_num)
		%menu_plate.position.x=self.page_num*340
		%menu_plate.origin.x=self.page_num*340
		self.disabled=true
	else:
		self.disabled=false




func _on_mouse_entered() -> void:
	mouse_inside=true
	await get_tree().create_timer(0.2).timeout #클라이언트 요청으로 절대 못빼는 코드, 버그의 원인
	if mouse_inside:
		var menu_tween=create_tween()
		menu_tween.tween_property(%menu_plate,"position",Vector2(340*self.page_num,0),0.3)


func _on_mouse_exited() -> void:
	mouse_inside=false
	var menu_tween=create_tween()
	menu_tween.tween_property(%menu_plate,"position",Vector2(340*core.nowpage,0),0.3)
