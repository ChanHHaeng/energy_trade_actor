extends GridContainer


var timeoption=[]
var value_min=0
var value_max=10000000
var price_min=0
var price_max=10000000





func _on_child_entered_tree(node: Node) -> void:
	match node.status:
		0:
			timeoption.append(int(str(node.name)[1]))
		1:
			value_min=$"../values/insert".min
			value_max=$"../values/insert".max
		2:
			price_min=$"../prices/insert".min
			price_max=$"../prices/insert".max
			
	


func _on_child_exiting_tree(node: Node) -> void:
	match node.status:
		0:
			timeoption.erase(int(str(node.name)[1]))
		1:
			value_min=0
			value_max=1000000
		2:
			price_min=0
			price_max=1000000
