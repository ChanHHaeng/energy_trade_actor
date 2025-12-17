extends Button

@onready var Id_label=$profile/ID

var _ID
@export var ID: int:
	set(value):
		_ID = value
		if Id_label:          # null 체크
			Id_label.text = "user%02d" %value
	get:
		if Id_label:
			return Id_label.text
		return _ID


func _ready() -> void:
	$profile.visible=false

func _on_pressed() -> void:
	$profile.visible=!$profile.visible
	ID=Global.building_id
