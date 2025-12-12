extends Control

signal certified

func activate():
	get_node("../Blur").visible=true
	self.visible=true
	%username.text=""
	%Password.text=""

func certification():
	self.visible=false
	get_node("../Blur").visible=false
	emit_signal("certified")
