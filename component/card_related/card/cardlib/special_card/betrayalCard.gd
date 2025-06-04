extends CardStrategyPattern
class_name BetrayalCard

func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece:int = piece_manager.array_pos.find(pos)
	if piece != -1:
		var instance_piece:Piece = piece_manager.get_child(piece)
		if instance_piece.rank_of_the_piece != 5:
			instance_piece.is_black = is_black
			instance_piece._change_texture()
		else:
			_do_reverse_not_activatable(gameplay_scene)
	else:
		_do_reverse_not_activatable(gameplay_scene)
	

func _custom_reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece:int = piece_manager.array_pos.find(pos)
	if piece != -1:
		var instance_piece:Piece = piece_manager.get_child(piece)
		instance_piece.is_black = (not is_black)
		instance_piece._change_texture()
	
func get_card_name()->String:
	return "Betrayal"
	
func get_description()->String:
	return "Change a piece color if it's not a king"
