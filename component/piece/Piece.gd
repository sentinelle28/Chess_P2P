extends Area2D
class_name Piece
@export var mouvement_option:Array[MouvementOption]
@export var rank_of_the_piece:int = 0
@export var pos:Vector2i



func get_possible_mouvement()->Array[Vector2i]:
	var array:Array[Vector2i] = []
	for option:MouvementOption in mouvement_option:
		array.append_array(option.get_possible_mouv())
	return array
