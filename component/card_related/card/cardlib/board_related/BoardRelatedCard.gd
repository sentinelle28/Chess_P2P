extends CardStrategyPattern
class_name BoardRelatedCard

func get_num_to_change()->int:
	return 0
	
func can_do_action(pos:Vector2i,array_of_piece:Array[Vector2i],tilemap:TileMapLayer)->bool:
	var is_in_board:bool = is_tile(tilemap,pos)
	return is_in_board and (not pos in array_of_piece)
	
func is_tile(tilemap:TileMapLayer,pos:Vector2i)->bool:
	return tilemap.get_cell_atlas_coords(pos) != Vector2i(-1,-1)

func _set_tile(_pos:Vector2i,_tilemap:TileMapLayer)->void:
	pass

func _apply(to_x:int,to_y:int,_is_black:bool,gameplay_scene:GameplayScene)->void:
	EventListenner.sub_turn_tick = 0
	SummonCardLib._reset_last_summon_array()
	var pos_to_check:Array[Vector2i] = [
		Vector2i(1,1),
		Vector2i(-1,-1),
		Vector2i(-1,0),
		Vector2i(1,-1),
		Vector2i(-1,1),
		Vector2i(1,0),
		Vector2i(0,-1),
		Vector2i(0,1)]
		
	var num_to_destroy:int = get_num_to_change()
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var tilemap:TileMapLayer = piece_manager.tilemap
	
	# easier to
	if can_do_action(pos,piece_manager.array_pos,tilemap):
		SummonCardLib.last_summon_array[4] = true
		_set_tile(pos,tilemap)
		num_to_destroy -= 1
		
	if num_to_destroy > 0:
		pos_to_check = get_shuffle_array(pos_to_check,gameplay_scene)
		for posi:Vector2i in pos_to_check:
			if can_do_action(pos + posi,piece_manager.array_pos,tilemap):
				num_to_destroy -= 1
				var c_index:int = (posi.x + 1) + (posi.y+1)*3
				SummonCardLib.last_summon_array[c_index] = true
				_set_tile(pos + posi,tilemap)
				if num_to_destroy <= 0:
					break
					
	if num_to_destroy == get_num_to_change():
		_do_reverse_not_activatable(gameplay_scene)
	
func get_shuffle_array(array:Array[Vector2i],gameplay:GameplayScene)->Array[Vector2i]:
	var copy_array:Array[Vector2i] = array.duplicate(true)
	seed(gameplay.get_randint(0,1000))
	copy_array.shuffle()
	return copy_array
	
	
func _set_board(new_pos:Vector2i,tilemap:TileMapLayer)->void:
	var posi:Vector2i
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
