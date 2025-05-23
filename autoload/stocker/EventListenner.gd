extends Node
signal PieceTaken(previous_pos:Vector2i,index_of_the_attacker:int)

var action:Action
var consequence:Array[Consequence] = []

func _ready() -> void:
	pass
	
func can_create_consequence()->bool:
	return is_instance_valid(action)
