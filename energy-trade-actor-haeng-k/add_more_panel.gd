@tool
extends Button

enum modes{buy,sell}

@export var mode:modes
@export var linecolor:Color
	
	
var disabling=false
@onready var example=load("res://data_example.tscn")
@onready var example_buy=load("res://assets/data_example_buy.tres")
@onready var example_sell=load("res://assets/data_example_sell.tres")
@onready var container=get_node("..").get_child(0)

var count=0
func _on_pressed() -> void:
	var examples=example.instantiate()
	if mode==1:
		examples.get_node("SubViewport/Panel").add_theme_stylebox_override('panel',example_sell)
		examples.get_node("SubViewport/Back").add_theme_stylebox_override('panel',example_sell)
	examples.name=str(count+1)
	count+=1
	#%trash.disabbled()
	container.add_child(examples)
	examples.presentation()
	if len(container.get_children())!=5:
		self.disabling=false
		self.visible=true
	
func _draw() -> void:
	draw_dotted_rect(Rect2(Vector2(0,0),self.size),linecolor, false ,30, 28, 2)


func draw_dotted_rect(rect: Rect2, color: Color, filled: bool = false, dot_size: float = 4.0, gap: float = 4.0, width:int=1) -> void:
	if filled:
		draw_rect(rect, color, true)
		return
	
	var start = rect.position
	var end = rect.position + rect.size

	# 위쪽 라인
	for x in range(start.x, end.x, int(dot_size + gap)):
		draw_capline(Vector2(x, start.y), Vector2(min(x + dot_size, end.x), start.y), color,width)

	# 아래쪽 라인
	for x in range(start.x, end.x, int(dot_size + gap)):
		draw_capline(Vector2(x, end.y), Vector2(min(x + dot_size, end.x), end.y), color, width)

	# 왼쪽 라인
	for y in range(start.y, end.y, int(dot_size + gap)):
		draw_capline(Vector2(start.x, y), Vector2(start.x, min(y + dot_size, end.y)), color, width)

	# 오른쪽 라인
	for y in range(start.y, end.y, int(dot_size + gap)):
		draw_capline(Vector2(end.x, y), Vector2(end.x, min(y + dot_size, end.y)), color, width)

func draw_capline(from,to,color,width):
	draw_line(from,to,color,width,true)
	draw_circle(from,width/2,color,true,-1,true)
	draw_circle(to,width/2,color,true,-1,true)
	pass

func _on_item_rect_changed() -> void:
	queue_redraw()
