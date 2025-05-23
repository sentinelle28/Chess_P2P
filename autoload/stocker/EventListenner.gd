extends Node
signal PieceTaken(index_of_the_victime:int,index_of_the_attacker:int)
signal PieceMov(from:Vector2i,to:Vector2i,who:int)

var action:Action
var consequences:Array[Consequence] = []

func did_action()->bool:
	return is_instance_valid(action)

func get_action()->Action:
	return action

func _ready() -> void:
	connect("PieceTaken",_add_piece_taken_consequence)
	connect("PieceMov",_add_movement_consequence)
	
func _reset_consequence()->void:
	consequences.clear()
	
func _add_consequence(consequence:Consequence)->void:
	consequences.append(consequence)
	
func _add_piece_taken_consequence(index_of_the_victime:int,
index_of_the_attacker:int)->void:
	pass
	
func _add_movement_consequence(from:Vector2i,to:Vector2i,who:int)->void:
	var new_action:MouvAction = MouvAction.new()
	new_action.new_pos = to
	new_action.index = who
	action = new_action
	var new_consequence:Consequence = MouvConsequence.new()
	new_consequence.index = who
	new_consequence.previous_pos = from
	_add_consequence(new_consequence)
	
func _reset_action()->void:
	action = null
	#consequence thingy
