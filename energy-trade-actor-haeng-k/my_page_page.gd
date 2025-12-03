extends Panel

var purcheck=false
var bidcheck=false

func _ready() -> void:
	self.visible=false


func activate():
	print("go")
	
func _on_visibility_changed() -> void:
	if visible:
		$Page.transactioning()
