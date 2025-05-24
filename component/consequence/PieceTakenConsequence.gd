extends Consequence
class_name PieceTakenConsequence
var index_of_the_victim:int

func _reverse(node:Node)->void:
	if node is PieceManager:
		node._make_alive(index_of_the_victim)
