extends Node
signal PieceTaken(index_of_the_victime:int,pos_of_the_victime:Vector2i)
signal PieceMov(from:Vector2i,to:Vector2i,who:int)
signal DidAction

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
	
func _add_piece_taken_consequence(index_of_the_victime:int,pos_of_the_victime:Vector2i)->void:
	var new_consequence:PieceTakenConsequence = PieceTakenConsequence.new()
	new_consequence.index_of_the_victim = index_of_the_victime
	new_consequence.pos_of_the_victim = pos_of_the_victime
	_add_consequence(new_consequence)
	
	print(is_multiplayer_authority())
	print(index_of_the_victime," got taken at pos:",pos_of_the_victime)
	
func _add_movement_consequence(from:Vector2i,to:Vector2i,who:int)->void:
	#describe action
	var new_action:MouvAction = MouvAction.new()
	new_action.new_pos = to
	new_action.index = who
	_add_action(new_action)
	print(is_multiplayer_authority())
	print(who," moves from: ",from," to: ",to)
	
	#mouv consequences
	var new_consequence:MouvConsequence = MouvConsequence.new()
	new_consequence.index = who
	new_consequence.previous_pos = from
	_add_consequence(new_consequence)
	
func _reset_action()->void:
	action = null
	#consequence thingy

func _add_action(n_action:Action)->void:
	action = n_action
	emit_signal("DidAction")
