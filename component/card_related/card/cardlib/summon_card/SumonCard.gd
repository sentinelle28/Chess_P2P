extends CardStrategyPattern
class_name SummonCardTemplate

func get_piece_to_summon()->int:
	return 0
	
func get_num_to_summon()->int:
	return 3

func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	SummonCardLib._reset_last_summon_array()
	_summon_range(Vector2i(to_x,to_y),gameplay_scene,is_black)

func _summon_range(pos:Vector2i,gameplay_scene:GameplayScene,is_black:bool)->void:
	var left_to_summon:int = get_num_to_summon()
	var tilemap:TileMapLayer = gameplay_scene.piece_manager.tilemap
	var array_of_piece:Array[Vector2i] = gameplay_scene.piece_manager.array_pos
	if can_summon(pos,tilemap,array_of_piece):
		SummonCardLib.last_summon_array[4] = true
		left_to_summon -= 1
		_summon(pos,is_black,gameplay_scene)
	
	if left_to_summon > 0:
		for y:int in range(-1,2):
			for x:int in range(-1,2):
				var new_pos:Vector2i = pos+Vector2i(x,y)
				if can_summon(new_pos,tilemap,array_of_piece):
					var index:int = (x + 1) + (y + 1) * 3 # find index base on pos
					SummonCardLib.last_summon_array[index] = true
					left_to_summon -= 1
					_summon(new_pos,is_black,gameplay_scene)
					if left_to_summon <= 0:
						break
			if left_to_summon <= 0:
				break
				
	if left_to_summon == get_num_to_summon():
		_do_reverse_not_activatable(gameplay_scene)

func _summon(pos:Vector2i,is_black:bool,gameplay:GameplayScene)->void:
	var piece:Piece = SummonCardLib.get_piece(get_piece_to_summon(),is_black)
	gameplay.piece_manager._add_piece(piece,pos)
	

func can_summon(pos:Vector2i,tilemap:TileMapLayer,array_of_piece:Array[Vector2i])->bool:
	# in board and not on another piece
	return (tilemap.get_cell_atlas_coords(pos) != Vector2i(-1,-1)) and (not pos in array_of_piece)

func _custom_reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	var piece_mana:PieceManager = gameplay_scene.piece_manager
	for i:int in range(9):
		if SummonCardLib.last_summon_array[i]:
			var x:int = i%4 - 1 #0 to 2 and then centered by -1 
			var y:int = i/3 - 1 #same
			var to_del:Vector2i = Vector2i(x,y) + pos
			var c_index:int = piece_mana.array_pos.find(to_del)
			piece_mana.array_pos.remove_at(c_index)
			piece_mana.remove_child(piece_mana.get_child(c_index))
	SummonCardLib._reset_last_summon_array()
	
