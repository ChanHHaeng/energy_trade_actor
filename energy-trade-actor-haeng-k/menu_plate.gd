extends Panel

var following_mouse=false
var tween_replace
var origin=Vector2(0,0)

#func _on_gui_input(event: InputEvent) -> void:
	#handle_mouse_click(event)
	
func handle_mouse_click(event: InputEvent) -> void:
	
	#if not event is InputEventMouseButton: return
	#if event.button_index != MOUSE_BUTTON_LEFT: return
	#if event.is_pressed():
	following_mouse = true
	Global.focusing=self
	#origin.x=self.position.x
	#following_mouse = false
	
	Global.focusing=null

	if near_searcher(self.position.x)!=origin.x:
		var near=near_searcher(self.position.x)
		tween_replace = create_tween()
		tween_replace.tween_property(self, "position:x", near, 0.1)
		if near==0:
			%Trade.button_pressed=true
		elif near==364:
			%Catalogue.button_pressed=true
		elif near==728:
			%"My Page".button_pressed=true
		origin.x=near

func follow_mouse(delta: float) -> void:
	if not following_mouse: return
	var mouse_pos: Vector2 = get_global_mouse_position()
	global_position.x = rangekiller((mouse_pos - (size*scale/2.0)).x)

#func _process(delta: float) -> void:
	#follow_mouse(delta)

func rangekiller(value:float):
	if value<get_parent().position.x:
		return get_parent().position.x
	elif value>get_parent().position.x+get_parent().size.x-300:
		return get_parent().position.x+get_parent().size.x-300
	else:
		return value

func near_searcher(value:float):
	if value<abs(value-364): # 182이하 조건 삭제
		return 0
	elif abs(value-364)<abs(728-value): # 546 이하 조건 삭제
		return 364
	else:
		return 728
	#return min(value,abs(value-364),abs(728-value))
