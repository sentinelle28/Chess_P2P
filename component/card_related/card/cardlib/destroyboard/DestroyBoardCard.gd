extends CardStrategyPattern
class_name DestroyBoardCardStrategyPattern

func get_num_to_destroy()->int:
	return 0
	
func can_destroy(pos:Vector2i,array_of_piece:Array[Vector2i],tilemap:TileMapLayer)->bool:
	var is_in_board:bool = tilemap.get_cell_atlas_coords(pos) != Vector2i(-1,-1)
	return is_in_board and (not pos in array_of_piece)
	

func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	SummonCardLib._reset_last_summon_array()
	var pos_to_check:Array[Vector2i] = [
		Vector2i(1,1),
		Vector2i(-1,-1),
		Vector2i(-1,0),
		Vector2i(1,-1),
		Vector2i(-1,1),
		Vector2i(0,0),
		Vector2i(1,0),
		Vector2i(0,-1),
		Vector2i(0,1)]
		
	var num_to_destroy:int = get_num_to_destroy()
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var tilemap:TileMapLayer = piece_manager.tilemap
	
	# easier to
	if can_destroy(pos,piece_manager.array_pos,tilemap):
		SummonCardLib.last_summon_array[4] = true
		_destroy(pos,tilemap)
		num_to_destroy -= 1
		
	if num_to_destroy > 0:
		for posi:Vector2i in pos_to_check:
			if can_destroy(pos + posi,piece_manager.array_pos,tilemap):
				num_to_destroy -= 1
				var c_index:int = (posi.x + 1) + (posi.y+1)*3
				SummonCardLib.last_summon_array[c_index] = true
				_destroy(pos + posi,tilemap)
				if num_to_destroy <= 0:
					break
					
	if num_to_destroy == get_num_to_destroy():
		_do_reverse_not_activatable(gameplay_scene)
	
func _destroy(pos:Vector2i,tilemap:TileMapLayer)->void:
	tilemap.set_cell(pos,0,Vector2i(-1,-1))
	
	
func _custom_reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	for i:int in range(9):
		if SummonCardLib.last_summon_array[i]:
			var x:int = i%3 - 1
			var y:int = i/3 - 1
			var posi:Vector2i = Vector2i(x,y)
			var tilemap:TileMapLayer = gameplay_scene.piece_manager.tilemap
			var new_pos:Vector2i = posi + pos
			if new_pos.y%2 == 0:
				if new_pos.x%2 == 0:
					posi = Vector2i(1,0)
				else:
					posi = Vector2i(0,0)
			else:
				if new_pos.x%2 == 0:
					posi = Vector2i(0,0)
				else:
					posi = Vector2i(1,0)
			tilemap.set_cell(new_pos,0,posi)
