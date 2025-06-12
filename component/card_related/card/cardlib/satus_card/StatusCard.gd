extends CardStrategyPattern
class_name StatusCard

func get_status_to_apply()->StatutStrategyPattern:
	return StatutStrategyPattern.new()

func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece:int = piece_manager.array_pos.find(pos)
	if piece != -1:
		var piece_instance:Piece = piece_manager.get_child(piece)
		if piece_instance.rank_of_the_piece != 5:
			var new_status:StatutStrategyPattern = get_status_to_apply()
			piece_manager.get_child(piece).add_child(new_status)
		else:
			_do_reverse_not_activatable(gameplay_scene)
	else:
		_do_reverse_not_activatable(gameplay_scene)


func _custom_reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece:int = piece_manager.array_pos.find(pos)
	if piece != -1:
		var piece_instance:Piece = piece_manager.get_child(piece)
		
		if piece_instance.get_child(piece_instance.get_child_count() - 1) is StatutStrategyPattern:
			var last_child:StatutStrategyPattern = piece_instance.get_child(piece_instance.get_child_count() - 1)
			last_child._reset_g_status()
