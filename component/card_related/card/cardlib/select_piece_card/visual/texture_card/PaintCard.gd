extends SelectPieceCard
class_name PaintCard

func get_rarity()->int:
	return 5 #1 to 5
	
func get_card_name()->String:
	return "Paint"
	
func get_description()->String:
	return "Change Piece color"
	
func _piece_reverse(piece:int,_pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece_ins:Piece = piece_manager.get_child(piece)
	piece_ins._change_texture()
	
func _piece_activate(piece:int,_pos:Vector2i,is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece_ins:Piece = piece_manager.get_child(piece)
	piece_ins._change_texture_bis(not piece_ins.is_black)
