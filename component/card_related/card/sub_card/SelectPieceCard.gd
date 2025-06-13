extends CardStrategyPattern
class_name SelectPieceCard
func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece:int = piece_manager.array_pos.find(pos)
	if piece != -1:
		_piece_activate(piece,pos,is_black,gameplay_scene)
	else:
		_do_reverse_not_activatable(gameplay_scene)
		
func _custom_reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece:int = piece_manager.array_pos.find(pos)
	if piece != -1:
		_piece_reverse(piece,pos,is_black,gameplay_scene)
		
func _piece_reverse(_piece:int,_pos:Vector2i,_is_black:bool,_gameplay_scene:GameplayScene)->void:
	pass
	
func _piece_activate(_piece:int,_pos:Vector2i,_is_black:bool,_gameplay_scene:GameplayScene)->void:
	pass
