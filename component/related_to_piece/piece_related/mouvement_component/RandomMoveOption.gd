extends ComputeMouvOption
class_name RandomMouvOption
func get_compute_possible_mouv(tilemap:TileMapLayer,
pos:Vector2i,
array_of_piece:Array[Vector2i])->Array[Vector2i]:
	var array:Array[Vector2i] = []
	var gameplay:GameplayScene = tilemap.get_tree().current_scene
	var x:int = gameplay.get_randint(-3,3)
	var y:int = gameplay.get_randint_seed(x+EventListenner.sub_turn_tick,-3,3)
	var posi:Vector2i = Vector2i(x,y)
	if is_in_board(posi+pos,tilemap):
		array.append(posi)
	EventListenner.sub_turn_tick += 1
	return array
