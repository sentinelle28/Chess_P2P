extends SelectPieceCard
class_name KingExcludedSelectCard

func _piece_activate(piece:int,pos:Vector2i,is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece_instance:Piece = piece_manager.get_child(piece)
	if piece_instance.rank_of_the_piece != 5:
		_not_king_piece_activate(piece,pos,is_black,gameplay_scene)
	else:
		_do_reverse_not_activatable(gameplay_scene)
		
func _not_king_piece_activate(piece:int,pos:Vector2i,is_black:bool,gameplay_scene:GameplayScene)->void:
	pass
