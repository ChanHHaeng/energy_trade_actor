extends Panel




func play():
	$AnimationPlayer.play("uploading")

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("k"):
		#print("go")
		#$AnimationPlayer.play("uploading")

func stop():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("RESET")
