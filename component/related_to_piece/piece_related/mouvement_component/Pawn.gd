extends ComputeMouvOption
class_name PawnMouvOption

func get_compute_possible_mouv(tilemap:TileMapLayer,
pos:Vector2i,
array_of_piece:Array[Vector2i] )->Array[Vector2i]:
	var array:Array[Vector2i] = [Vector2i(1,0),
	Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1)]
	var to_check:Array[Vector2i] = [Vector2i(1,1),
	Vector2i(1,-1),Vector2i(-1,-1),Vector2i(-1,1)]
	for i:int in range(len(array)):
		if not is_in_board(array[i]+pos,tilemap):
			array.erase(array[i])
			
		if is_in_board(to_check[i],tilemap) and not is_empity(to_check[i]+pos,array_of_piece):
			array.append(to_check[i])

	return array
