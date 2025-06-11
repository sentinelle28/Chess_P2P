extends CardStrategyPattern
class_name HazardousBulletCard

func get_rarity()->int:
	return 3 #1 to 5
	
func get_card_name()->String:
	return "Hazardous Bullet"
	
func get_description()->String:
	return "Either you die or your opponent"
	
func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	if pos in piece_manager.array_pos:
		var c_index:int = piece_manager.array_pos.find(pos)
		var piece:Piece = piece_manager.get_child(c_index)
		piece._change_texture_bis(not piece.is_black)
	else:
		_do_reverse_not_activatable(gameplay_scene)
	
	
func _custom_reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	if pos in piece_manager.array_pos:
		var c_index:int = piece_manager.array_pos.find(pos)
		var piece:Piece = piece_manager.get_child(c_index)
		piece._change_texture()
