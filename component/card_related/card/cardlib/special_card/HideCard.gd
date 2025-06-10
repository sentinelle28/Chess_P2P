extends CardStrategyPattern
class_name HideCard

func get_rarity()->int:
	return 5 #1 to 5
	
func get_card_name()->String:
	return "Hide"
	
func get_description()->String:
	return "Make a piece transparent"
	
func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	if pos in piece_manager.array_pos:
		var c_index:int = piece_manager.array_pos.find(pos)
		var piece:Piece = piece_manager.get_child(c_index)
		piece.modulate.a = 0.1
	else:
		_do_reverse_not_activatable(gameplay_scene)
	
	
func _custom_reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	if pos in piece_manager.array_pos:
		var c_index:int = piece_manager.array_pos.find(pos)
		var piece:Piece = piece_manager.get_child(c_index)
		piece.modulate.a = 1.0
