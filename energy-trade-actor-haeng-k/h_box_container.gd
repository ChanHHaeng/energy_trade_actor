extends HBoxContainer

enum modes{buy,sell}

@export var mode:modes
var cardlen=Global.cardlen

@onready var input_button=get_node("../input_button")
var no_color = Color(0.88, 0.88, 0.88)
var yes_color = Color(0.44, 0.44, 0.44)


func _on_child_exiting_tree(node: Node) -> void:
	await get_tree().process_frame
	#timer 글자 색깔 조정
	if len(%buyDataContainer.get_children())+len(%sellDataContainer.get_children())==0:
		get_owner().add_theme_color_override("font_color",no_color)
	#fold쪽 카드 펼쳐지는 갯수
	for i in range(5):
		if self.mode==0:
			%upperfold.get_child(i).visible=i<len(get_children())
		elif self.mode==1:
			%downfold.get_child(i).visible=i<len(get_children())
	button_position()
	# check도중에 버튼 사라지는 것 방지
	if len(get_children())<5:
		#if !get_owner().checkingmode:
		input_button.disabling=false
		input_button.visible=true
	get_owner().stacking()


##테스트용 여러 가지 출력을 위한 K키 커맨드 
func _input(event: InputEvent) -> void:
	if get_parent().visible:
		if event.is_action_pressed("k"):
			get_owner().add_theme_color_override("font_color",yes_color)


func _on_child_entered_tree(node: Node) -> void:
	await get_tree().process_frame
	#자식 노드가 있으므로 yes color로 전환
	get_owner().add_theme_color_override("font_color",yes_color)
	get_owner().queue_redraw()
	
	#fold쪽 카드 펼쳐지는 갯수
	for i in range(5):
		if self.mode==0:
			%upperfold.get_child(i).visible=i<len(get_children())
		elif self.mode==1:
			%downfold.get_child(i).visible=i<len(get_children())
	button_position()
	if len(get_children())==5:
		input_button.disabling=true
		input_button.visible=false
		
#비활성화 모드
func _draw() -> void:
	if %trash.acting:
		for i in get_children():
			draw_dotted_rect(Rect2(i.position.x-5,i.position.y-3,150,150),Color.RED,false,3)
		
#도트 사각형 그려주는 코드
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

#데이터를 dish로 추출
func get_data() -> Array:
	var dish=[]
	for i in get_children():
		dish.append([int(i.amount),int(i.price)])
	return dish


func button_position():
	input_button.position=Vector2(26,57.5)+(Vector2(186,0)*len(get_children()))
