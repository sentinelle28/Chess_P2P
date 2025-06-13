extends KingExcludedSelectCard
class_name StatusCard

func get_status_to_apply()->StatutStrategyPattern:
	return StatutStrategyPattern.new()

func _piece_reverse(piece:int,_pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece_instance:Piece = piece_manager.get_child(piece)
	if piece_instance.get_child(piece_instance.get_child_count() - 1) is StatutStrategyPattern:
		var last_child:StatutStrategyPattern = piece_instance.get_child(piece_instance.get_child_count() - 1)
		last_child._reset_g_status()

func _not_king_piece_activate(piece:int,_pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var new_status:StatutStrategyPattern = get_status_to_apply()
	piece_manager.get_child(piece).add_child(new_status)
