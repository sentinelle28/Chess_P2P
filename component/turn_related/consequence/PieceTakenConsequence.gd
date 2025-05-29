extends Consequence
class_name PieceTakenConsequence
var index_of_the_victim:int
var pos_of_the_victim:Vector2i

func _reverse(node:Node)->void:
	if node is PieceManager:
		node._make_alive(index_of_the_victim,pos_of_the_victim)
