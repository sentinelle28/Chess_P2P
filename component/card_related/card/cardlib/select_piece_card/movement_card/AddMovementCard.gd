extends SelectPieceCard
class_name AddMovementCard
func get_mouv_to_add()->int:
	return 0

func _piece_reverse(piece:int,_pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager = gameplay_scene.piece_manager
	var piece_ins:Piece = piece_manager.get_child(piece)
	piece_ins.mouvement_option.erase(get_mouv_to_add())
	
func _piece_activate(piece:int,_pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager = gameplay_scene.piece_manager
	var piece_ins:Piece = piece_manager.get_child(piece)
	piece_ins.mouvement_option.append(get_mouv_to_add())
