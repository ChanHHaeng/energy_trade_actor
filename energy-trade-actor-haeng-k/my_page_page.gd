extends Panel

var purcheck=false
var bidcheck=false

func _ready() -> void:
	self.visible=false
	


func activate():
	$Page.transactioning()
