extends CardStrategyPattern
class_name ConfusionCard

func get_rarity()->int:
	return 2 #1 to 5
	
func get_card_name()->String:
	return "Confusion"
	
func get_description()->String:
	return "Make a piece moves randomly"
	
func _apply(to_x:int,to_y:int,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	if pos in piece_manager.array_pos:
		var c_index:int = piece_manager.array_pos.find(pos)
		var piece:Piece = piece_manager.get_child(c_index)
		var previous_pos:Vector2i = piece_manager.array_pos[c_index]
		var new_pos:Vector2i = previous_pos + Vector2i(gameplay_scene.get_randint(-1,1),gameplay_scene.get_randint(-1,1))
		piece_manager._update_pos(c_index,new_pos,true)
	else:
		_do_reverse_not_activatable(gameplay_scene)
	
	
