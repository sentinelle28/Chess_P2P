extends SelectPieceCard
class_name DiguiseCard
func get_rarity()->int:
	return 3 #1 to 5
	
func get_card_name()->String:
	return "Diguise"
	
func get_description()->String:
	return "Change the apparence of a piece"
	
func _piece_reverse(piece:int,_pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	piece_manager._reset_piece_rank(piece_manager.get_child(piece))
	
func _piece_activate(piece:int,_pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece_ins:Piece = piece_manager.get_child(piece)
	piece_ins._update_frame_coords(gameplay_scene.get_randint(0,5))
