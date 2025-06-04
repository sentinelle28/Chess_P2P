extends CardStrategyPattern
class_name AddMovementCard
	
func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var index:int = piece_manager.array_pos.find(Vector2i(to_x,to_y))
	if index != -1:
		var piece:Piece = piece_manager.get_child(index)
		piece.mouvement_option.append(get_mouv_to_add())
	else:
		_do_reverse_not_activatable(gameplay_scene)
	
	
func get_mouv_to_add()->int:
	return 0

func _custom_reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var c_index:int = piece_manager.array_pos.find(Vector2i(to_x,to_y))
	if c_index != -1:
		var piece:Piece = piece_manager.get_child(c_index)
		piece.mouvement_option.erase(get_mouv_to_add())
