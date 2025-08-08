@tool
extends GridContainer

func _ready() -> void:
	#if Engine.is_editor_hint() and get_child_count() == 0:
		#var root = get_tree().edited_scene_root
		#for i in range(24):
			#var time = Label.new()
			#time.text = "%02d:00" % [i]
			#time.add_theme_color_override('font_color',Color.BLACK)
			#time.name=time.text
			#add_child(time)
			#time.owner= root
	pass
	if Engine.is_editor_hint() and get_child_count() == 24:
		var root = get_tree().edited_scene_root
		for i in range(24):
			var value = SpinBox.new()
			var text = "%02d:00 value" % [i]
			#time.add_theme_color_override('font_color',Color.BLACK)
			value.name=text
			add_child(value)
			value.owner= root
