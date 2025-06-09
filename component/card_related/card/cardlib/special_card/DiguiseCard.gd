extends CardStrategyPattern
class_name DiguiseCard
func get_rarity()->int:
	return 3 #1 to 5
	
func get_card_name()->String:
	return "Diguise"
	
func get_description()->String:
	return "Change the apparence of a piece"
	
func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	if pos in piece_manager.array_pos:
		var c_index:int = piece_manager.array_pos.find(pos)
		var piece:Piece = piece_manager.get_child(c_index)
		piece._update_frame_coords(gameplay_scene.get_randint(0,5))
	else:
		_do_reverse_not_activatable(gameplay_scene)
	
	
func _custom_reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	if pos in piece_manager.array_pos:
		var c_index:int = piece_manager.array_pos.find(pos)
		piece_manager._reset_piece(piece_manager.get_child(c_index))
	
