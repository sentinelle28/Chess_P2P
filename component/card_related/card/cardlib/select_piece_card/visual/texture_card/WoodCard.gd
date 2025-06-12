extends SelectPieceCard
class_name WoodCard

func get_rarity()->int:
	return 2 #1 to 5
	
func get_card_name()->String:
	return "Woodification"
	
func get_description()->String:
	return "Transform a piece into a wooden piece"
	
func _piece_reverse(piece:int,_pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece_ins:Piece = piece_manager.get_child(piece)
	piece_ins._change_texture()
	
func _piece_activate(piece:int,_pos:Vector2i,is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece_ins:Piece = piece_manager.get_child(piece)
	if piece_ins.is_black:
		piece_ins.sprite.texture = load("res://asset/visual/pixel chess_v1.2/16x16 pieces/BlackPieces_Wood.png")
	else:
		piece_ins.sprite.texture = load("res://asset/visual/pixel chess_v1.2/16x16 pieces/WhitePieces_Wood.png")
