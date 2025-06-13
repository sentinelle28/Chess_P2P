extends CardStrategyPattern
class_name WindCardStrategyPattern

func get_direction()->Vector2i:
	return Vector2i(0,0)


func _apply(_to_x:int,_to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var piece_to_move:Array[int] = []
	var count:int = 0
	for child:Piece in piece_manager.get_children():
		if child.visible and child.is_black != is_black:
			piece_to_move.append(count)
		count += 1
	
	#move child without checking for kill yet
	for c_index:int in piece_to_move:
		var where_to:Vector2i = piece_manager.array_pos[c_index]+get_direction()
		if piece_manager.is_valid_tile(where_to):
			piece_manager._anim_pos(c_index,where_to,true)
	
	#check for kill
	for c_index:int in piece_to_move:
		var previous_pos:Vector2i = piece_manager.array_pos[c_index]
		#prevent not working kill
		piece_manager.array_pos[c_index] = Vector2i(-100,100)
		
		piece_manager._check_for_kill(c_index,previous_pos,true)
		piece_manager.array_pos[c_index] = previous_pos
	
	
	
func _custom_reverse(_to_x:int,_to_y:int,_is_black:bool,_gameplay_scene:GameplayScene)->void:
	pass
