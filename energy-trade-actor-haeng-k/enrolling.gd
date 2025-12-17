extends Panel

var cancelled=false

signal enrollsig(boolean:bool)

func show_select():
	cancelled=false
	%Blur.visible=true
	%Blur.mouse_filter=2
	self.visible=true
	$enroll_icon.play()
	await visibility_changed
	#if !self.visible:
		#pass
	#else:
		#enrollsig.emit(false)
		#self.visible=false


func _on_yes_pressed() -> void:
	print("yes!")
	emit_signal("enrollsig",true)
	self.visible=false


func _on_no_pressed() -> void:
	print("no!")
	enrollsig.emit(false)
	%Blur.visible=false
	%Blur.mouse_filter=0
	self.visible=false
