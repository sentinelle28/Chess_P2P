extends Node
signal PieceTaken(index_of_the_victime:int,pos_of_the_victime:Vector2i) #emited from piece manager to self
signal PieceMov(from:Vector2i,to:Vector2i,who:int) #emited from piece manager to self
signal UseCard(CardIndex:int,pos:Vector2i,is_black:bool) # emited from card manager to self
signal DidAction # prevent mouse from doing two action

var action:Action
var consequences:Array[Consequence] = []
var sub_turn_tick:int = 0

func _reset_sub_tick()->void:
	sub_turn_tick = 0

func did_action()->bool:
	return is_instance_valid(action)

func get_action()->Action:
	return action

func _ready() -> void:
	connect("PieceTaken",_add_piece_taken_consequence)
	connect("PieceMov",_add_movement_consequence)
	connect("UseCard",_add_card_consequence)
	
func _reset_consequence()->void:
	consequences.clear()
	_reset_sub_tick()
	
func _add_card_consequence(CardIndex:int,pos:Vector2i,is_black:bool)->void:
	var consequence:CardConsequence = CardConsequence.new()
	consequence.card_index = CardIndex
	consequence.pos = pos
	consequence.is_black = is_black
	_add_consequence(consequence)
	
	print("use ",CardLib.array_of_card[CardIndex].get_card_name()," on tile ",pos)
	#_add_action
	var c_action:CardAction = CardAction.new()
	c_action.card_index = CardIndex
	c_action.pos = pos
	c_action.is_black = is_black
	_add_action(c_action)
	#execute action
	action._do_action(get_tree().current_scene)
	
	
	
	
func _add_consequence(consequence:Consequence)->void:
	consequences.append(consequence)
	
func _add_piece_taken_consequence(index_of_the_victime:int,pos_of_the_victime:Vector2i)->void:
	SoundManager._play_sfx("TookPiece")
	var new_consequence:PieceTakenConsequence = PieceTakenConsequence.new()
	new_consequence.index_of_the_victim = index_of_the_victime
	new_consequence.pos_of_the_victim = pos_of_the_victime
	_add_consequence(new_consequence)
	
	print(is_multiplayer_authority())
	print(index_of_the_victime," got taken at pos:",pos_of_the_victime)
	
func _add_movement_consequence(from:Vector2i,to:Vector2i,who:int)->void:
	#mouv consequences
	var new_consequence:MouvConsequence = MouvConsequence.new()
	new_consequence.index = who
	new_consequence.previous_pos = from
	_add_consequence(new_consequence)
	
	#describe action
	if not is_instance_valid(action):
		var new_action:MouvAction = MouvAction.new()
		new_action.new_pos = to
		new_action.index = who
		_add_action(new_action)
		print(is_multiplayer_authority())
		print(who," moves from: ",from," to: ",to)
	
	
	
func _reset_action()->void:
	action = null
	#consequence thingy

func _add_action(n_action:Action)->void:
	action = n_action
	emit_signal("DidAction")
