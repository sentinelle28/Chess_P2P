extends Resource
class_name MouvementOption
@export var pos_array:Array[Vector2i] = []

func get_possible_mouv()->Array[Vector2i]:
	return pos_array
