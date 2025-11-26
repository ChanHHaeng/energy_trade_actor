extends Control


@onready var amount_line=%Amount_line
@onready var price_line=%price_line

var following_mouse: bool = false
@onready var collision_shape = $Area2D/CollisionShape2D
var last_pos: Vector2
var tween_hover: Tween
var tween_handle: Tween
var tween_rot
var tween_replace : Tween
@onready var sub_viewport: SubViewport = $SubViewport
var displacement: float = 0.0 
@export var damp: float = 10.0


var move_impossible = false
var bin_activated=false

var origin:Vector2

var _amount: String = ""
@export var amount: String:
	set(value):
		_amount = value
		if amount_line:          # null 체크
			amount_line.text = value
			amount_line.prev_text=value
			amount_line.correct_form=true
	get:
		if amount_line:
			return amount_line.text
		return _amount
var _price : String =""

@export var price: String:
	set(value):
		_price = value
		if price_line:          # null 체크
			price_line.text = value
			price_line.prev_text=value
			price_line.correct_form=true
	get:
		if price_line:
			return price_line.text
		return _price


func _ready() -> void:
	amount=_amount
	price=_price
	if price_line.correct_form and amount_line.correct_form:
		amount_line.totalling()
	#amount_line.text=_amount
	#amount_line.prev_text=_amount
	#price_line.text=_price
	#price_line.prev_text=_amount
	#collision_shape.set_deferred("disabled", true)
	material=material.duplicate()
	await get_tree().process_frame
	%Amount_line.connect("focus_entered", func():
		move_impossible=true
	)
	%Amount_line.connect("focus_exited", func():
		move_impossible=false
	)

func _process(delta: float) -> void:
	follow_mouse(delta)
	


func _on_suicide_button_pressed() -> void:
	queue_free()
	




func _on_gui_input(event: InputEvent) -> void:
	handle_mouse_click(event)
	
func handle_mouse_click(event: InputEvent) -> void:
	
	if not event is InputEventMouseButton: return
	if event.button_index != MOUSE_BUTTON_LEFT: return
	if event.is_pressed():
		print(sub_viewport.gui_get_focus_owner())
		following_mouse = true
		Global.focusing=self
		origin=self.position
		self.z_index=1
		
	else:
		following_mouse = false
		self.z_index=0
		
		Global.focusing=null
		if self.position!=origin and !bin_activated:
			tween_replace = create_tween().set_parallel(true)
			tween_replace.tween_property(self, "position:y", origin.y, 0.1)
			tween_replace.tween_property(self, "position:x", origin.x, 0.1)
			#get_node("SubViewport/Panel").modulate.a=1
		elif bin_activated:
			$AnimationPlayer.play("Panel_trash")
			await $AnimationPlayer.animation_finished
			get_parent().get_node("../TextureRect").return_to_deactivate()
			self.queue_free()
			return
		if tween_handle and tween_handle.is_running():
			tween_handle.kill()
		
		
		
func follow_mouse(delta: float) -> void:
	if not following_mouse: return
	if get_child(0).get_viewport().gui_get_focus_owner() is LineEdit or get_child(0).get_viewport().gui_get_focus_owner() is Button: return
	var mouse_pos: Vector2 = get_global_mouse_position()
	if bin_activated:
		self.scale=Vector2(0.5,0.5)
		get_node("SubViewport/Panel").modulate.a=0.5
	else:
		self.scale=Vector2(1,1)
		get_node("SubViewport/Panel").modulate.a=1
	global_position = (mouse_pos - (size*scale/2.0))
		
	#get_node("SubViewport/Panel").modulate.a=(180-abs(self.position.y))/140
	
#func _draw() -> void:
	#draw_rect(Rect2(0,0,30,30),Color.RED,true,10,true)
	
func delmode():
	print("delmode~")
	%suicide_Button.visible=true


func normalmode():
	%suicide_Button.visible=false
	
	
func presentation():
	$AnimationPlayer.play("Panel_trash")
	
	
	
