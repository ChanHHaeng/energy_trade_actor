extends Polygon2D

@export var length := 200.0
@export var max_thickness := 40.0
@export var segments := 64

func _ready():
	polygon = make_smooth_spindle(length, max_thickness, segments)


func make_smooth_spindle(len: float, thick: float, seg: int) -> PackedVector2Array:
	var pts := PackedVector2Array()
	var half := len * 0.5

	# ----- 상단 곡선 -----
	for i in range(seg + 1):
		var t = float(i) / float(seg)       # 0~1
		var x = lerp(-half, half, t)

		# 부드러운 곡선 폭 (사다리꼴이 아니라 곡선)
		var width = thick * sin(PI * t)

		pts.append(Vector2(x, -width * 0.5))

	# ----- 하단 곡선 -----
	for i in range(seg, -1, -1):
		var t = float(i) / float(seg)
		var x = lerp(-half, half, t)
		var width = thick * sin(PI * t)

		pts.append(Vector2(x, width * 0.5))

	return pts
