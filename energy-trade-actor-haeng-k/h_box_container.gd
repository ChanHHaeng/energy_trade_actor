extends HBoxContainer


var cardlen=Global.cardlen

var no_color = Color(0.88, 0.88, 0.88)
var yes_color = Color(0.44, 0.44, 0.44)


func _on_child_exiting_tree(node: Node) -> void:
	await get_tree().process_frame
	#print( get_owner().name," ",get_parent().size_memory," exit")
	if len($"../../down/HBoxContainer".get_children())==0 and len($"../../Upper/HBoxContainer".get_children())==0:
		$"../../..".add_theme_color_override("font_color",no_color)
	set_anchors_preset(Control.PRESET_CENTER)
	set_offsets_preset(Control.PRESET_CENTER)
	for i in range(len(get_children())):
		if get_parent().name=="down":
			%downfold.get_child(i).visible=true
		else:
			%upperfold.get_child(i).visible=true
	for i in range(len(get_children()),5,1):
		if get_parent().name=="down":
			%downfold.get_child(i).visible=false
		else:
			%upperfold.get_child(i).visible=false
	if len(get_children())<5:
		if get_parent().resize_flag and !get_owner().checkingmode:
			$"../Button".disabling=false
			$"../Button".visible=true
	self.size.x-=cardlen
	$"..".size.x-=cardlen
	$"../../..".stacking()

func _input(event: InputEvent) -> void:
	if get_parent().visible:
		if event.is_action_pressed("k") and get_parent().name == "down":
			$"../../..".add_theme_color_override("font_color",yes_color)
			#await get_tree().process_frame

func _on_child_entered_tree(node: Node) -> void:
	print(get_node("../../.."))
	await get_tree().process_frame
	#print( get_owner().name," ",get_parent().size_memory," enter")
	$"../../..".add_theme_color_override("font_color",yes_color)
	$"../../..".queue_redraw()
	set_anchors_preset(Control.PRESET_CENTER)
	set_offsets_preset(Control.PRESET_CENTER)
	for i in range(len(get_children())):
		
		if get_parent().name=="down":
			$"../../../downfold".get_child(i).visible=true
		else:
			$"../../../upperfold".get_child(i).visible=true
	for i in range(len(get_children()),5,1):
		if get_parent().name=="down":
			$"../../../downfold".get_child(i).visible=false
		else:
			$"../../../upperfold".get_child(i).visible=false

	if len(get_children())==5:
		$"../Button".disabling=true
		$"../Button".visible=false
		
func _draw() -> void:
	if $"../TextureRect".acting:
		for i in get_children():
			draw_dotted_rect(Rect2(i.position.x-5,i.position.y-3,150,150),Color.RED,false,3)
		

func draw_dotted_rect(rect: Rect2, color: Color, filled: bool = false, dot_size: float = 4.0, gap: float = 4.0) -> void:
	if filled:
		draw_rect(rect, color, true)
		return
	
	var start = rect.position
	var end = rect.position + rect.size

	# 위쪽 라인
	for x in range(start.x, end.x, int(dot_size + gap)):
		draw_line(Vector2(x, start.y), Vector2(min(x + dot_size, end.x), start.y), color, 1)

	# 아래쪽 라인
	for x in range(start.x, end.x, int(dot_size + gap)):
		draw_line(Vector2(x, end.y), Vector2(min(x + dot_size, end.x), end.y), color, 1)

	# 왼쪽 라인
	for y in range(start.y, end.y, int(dot_size + gap)):
		draw_line(Vector2(start.x, y), Vector2(start.x, min(y + dot_size, end.y)), color, 1)

	# 오른쪽 라인
	for y in range(start.y, end.y, int(dot_size + gap)):
		draw_line(Vector2(end.x, y), Vector2(end.x, min(y + dot_size, end.y)), color, 1)
