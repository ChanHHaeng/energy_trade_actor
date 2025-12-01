extends Panel

var cancelled=false

signal enrollsig(boolean:bool)

func show_select():
	cancelled=false
	self.visible=true
	$Timer.start(5.0)
	await $Timer.timeout or visibility_changed
	if !self.visible:
		pass
	else:
		enrollsig.emit(false)
		self.visible=false


func _on_yes_pressed() -> void:
	emit_signal("enrollsig",true)
	self.visible=false


func _on_no_pressed() -> void:
	enrollsig.emit(false)
	self.visible=false
