extends CardStrategyPattern
class_name AddMovementCard

func get_card_name()->String:
	return "Template"
	
func get_description()->String:
	return "None"
	
func get_rarity()->int:
	return 0
	
func get_cost()->int:
	return 0

func _apply(to_x:int,to_y:int,is_black:bool,piece_manager:PieceManager)->void:
	var index:int = piece_manager.array_pos.find(Vector2i(to_x,to_y))
	var piece:Piece = piece_manager.get_child(index)
	piece.mouvement_option.append(get_mouv_to_add())
	

func get_mouv_to_add()->int:
	return 0

func _reverse(to_x:int,to_y:int,is_black:bool,piece_manager:PieceManager)->void:
	var c_index:int = piece_manager.array_pos.find(Vector2i(to_x,to_y))
	var piece:Piece = piece_manager.get_child(c_index)
	piece.mouvement_option.erase(get_mouv_to_add())
