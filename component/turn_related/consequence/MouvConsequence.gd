extends Consequence
class_name MouvConsequence
var index:int
var previous_pos:Vector2i

func _reverse(node:Node)->void:
	if node is PieceManager:
		node._anim_pos(index,previous_pos,false)
