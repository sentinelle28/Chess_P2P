extends MouvementOption
class_name ComputeMouvOption


func is_in_board(pos:Vector2i,tilemap:TileMapLayer)->bool:
	return tilemap.get_cell_atlas_coords(pos) != Vector2i(-1,-1)
	
func get_compute_possible_mouv(_tilemap:TileMapLayer,
_pos:Vector2i,
_array_of_piece:Array[Vector2i] )->Array[Vector2i]:
	var array:Array[Vector2i] = []
	return array


func is_empity(pos:Vector2i,array:Array[Vector2i])->bool:
	return not (pos in array)
