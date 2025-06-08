extends CardStrategyPattern
class_name DuplicateCard
func get_rarity()->int:
	return 5 #1 to 5


func get_card_name()->String:
	return "Duplicate"
	
func get_description()->String:
	return "Duplicate any piece"
	
func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	SummonCardLib._reset_last_summon_array()
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	if pos in piece_manager.array_pos:
		var c_index:int = piece_manager.array_pos.find(pos)
		var to_duplicate:Piece = piece_manager.get_child(c_index)
		if to_duplicate.rank_of_the_piece == 5:
			_do_reverse_not_activatable(gameplay_scene)
		else:
			var tilemap:TileMapLayer = gameplay_scene.piece_manager.tilemap
			var possible_spawn_pos:Array[Vector2i] = []
			for y:int in range(-1,2):
				for x:int in range(-1,2):
					var new_pos:Vector2i = pos + Vector2i(x,y)
					if tilemap.get_cell_atlas_coords(new_pos) != Vector2i(-1,-1):
						possible_spawn_pos.append(Vector2i(x,y))
			if len(possible_spawn_pos) == 0:
				_do_reverse_not_activatable(gameplay_scene)
			else:
				var c_maxi:int = len(possible_spawn_pos) - 1
				var rand:int = gameplay_scene.get_randint(0,c_maxi)
				var new_pos:Vector2i = possible_spawn_pos[rand]
				
				
				
				var new_piece:Piece = load("res://instance/piece_instance/PieceInstance.tscn").instantiate()
				new_piece.rank_of_the_piece = to_duplicate.rank_of_the_piece
				new_piece.is_black = to_duplicate.is_black
				new_piece.mouvement_option = to_duplicate.mouvement_option.duplicate()
				gameplay_scene.piece_manager._add_piece(new_piece,new_pos+pos)
				
				
				var n_index:int = (new_pos.x+1) + 3*(new_pos.y+1)
				
				SummonCardLib.last_summon_array[n_index] = true
			
	else:
		_do_reverse_not_activatable(gameplay_scene)
	
	
	
	
	
func _custom_reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	for i:int in range(9):
		if SummonCardLib.last_summon_array[i]:
			var x:int = i%3 - 1
			var y:int = i/3 - 1
			var pos:Vector2i = Vector2i(x+to_x,y+to_y)
			var c_index:int = gameplay_scene.piece_manager.array_pos.find(pos)
			gameplay_scene.piece_manager.remove_child(gameplay_scene.piece_manager.get_child(c_index))
			break
	
