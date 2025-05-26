extends Consequence
class_name CardConsequence
var card_index:int
var pos:Vector2i
var is_black:bool

func _reverse(node:Node)->void:
	if node is PieceManager:
		CardLib.array_of_card[card_index]._reverse(pos.x,pos.y,is_black,node)
