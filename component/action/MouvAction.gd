extends Action
class_name MouvAction

var index:int
var new_pos:Vector2i

func _do_action(node:Node)->void:
	if node is PieceManager:
		node._update_pos(index,new_pos)
		
