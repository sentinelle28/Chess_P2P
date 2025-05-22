extends Node
class_name PieceManager



var array_pos:Array[Vector2i] = []

func _ready() -> void:
	for i:int in range(get_child_count()):
		var child:Piece = get_child(i)
		child.pos = PosReset.beginning_pos[i]
		array_pos.append(child.pos)
	
func _update_pos(index:int,value:Vector2i)->void:
	array_pos[index] = value
