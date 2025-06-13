extends KingExcludedSelectCard
class_name BetrayalCard

func _not_king_piece_activate(piece:int,_pos:Vector2i,is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var instance_piece:Piece = piece_manager.get_child(piece)
	instance_piece.is_black = is_black
	instance_piece._change_texture()

	

func _piece_reverse(piece:int,_pos:Vector2i,is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var instance_piece:Piece = piece_manager.get_child(piece)
	instance_piece.is_black = (not is_black)
	instance_piece._change_texture()
	
func get_card_name()->String:
	return "Betrayal"
	
func get_description()->String:
	return "Make the piece yours"
	
func get_rarity()->int:
	return 4 #1 to 5
