extends SelectPieceCard
class_name LostControlCard

func get_rarity()->int:
	return 5 #1 to 5
	
func get_card_name()->String:
	return "Medusa"
	
func get_description()->String:
	return "prevent a piece from ever moving again"

func _piece_reverse(piece:int,_pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece_ins:Piece = piece_manager.get_child(piece)
	piece_ins.monitorable = true
	
func _piece_activate(piece:int,_pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece_ins:Piece = piece_manager.get_child(piece)
	piece_ins.monitorable = false
