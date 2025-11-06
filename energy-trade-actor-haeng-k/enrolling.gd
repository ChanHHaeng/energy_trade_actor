extends Panel

var cancelled=false

func show_select():
	pass
	#cancelled=false
	#print("enrolling!")
	#self.visible=true
	#$Timer.start(5.0)
	#while true:
		#if cancelled:
			#self.visible=false
			#return true
		#if ($Timer.is_stopped() and $Timer.time_left<=0):
			#self.visible=false
			#return false
		#await get_tree().process_frame


func _on_yes_pressed() -> void:
	cancelled=true
