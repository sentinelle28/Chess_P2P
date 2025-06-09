extends ComputeMouvOption
class_name ExtandCompute

func get_direction(direction:Vector2i,
tilemap:TileMapLayer,
pos:Vector2i,
array_of_piece:Array[Vector2i])->Array[Vector2i]:
	var array:Array[Vector2i] = []
	for i:int in range(1,9):
		var current_pos:Vector2i = direction*i + pos
		if is_in_board(current_pos,tilemap):
			if is_empity(current_pos,array_of_piece):
				array.append(direction*i)
			elif not is_empity(current_pos,array_of_piece):
				array.append(direction*i)
				break
		else:
			break
	return array
	
func get_compute_possible_mouv(tilemap:TileMapLayer,
pos:Vector2i,
array_of_piece:Array[Vector2i] )->Array[Vector2i]:
	var array:Array[Vector2i] = []
	for direction:Vector2i in pos_array:
		array.append_array(get_direction(direction,
		tilemap,
		pos,
		array_of_piece))

	return array
