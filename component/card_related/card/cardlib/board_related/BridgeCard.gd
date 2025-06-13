extends BoardRelatedCard
class_name BridgeCard

func get_card_name()->String:
	return "Bridge"
	
func get_description()->String:
	return "Make a Bridge"
	
func get_rarity()->int:
	return 3 #1 to 5


func get_num_to_change()->int:
	return 9

func is_tile(tilemap:TileMapLayer,pos:Vector2i)->bool:
	return tilemap.get_cell_atlas_coords(pos) == Vector2i(-1,-1)

func _set_tile(pos:Vector2i,tilemap:TileMapLayer)->void:
	_set_board(pos,tilemap)
	
func _custom_reverse(to_x:int,to_y:int,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var pos:Vector2i = Vector2i(to_x,to_y)
	for i:int in range(9):
		if SummonCardLib.last_summon_array[i]:
			var x:int = i%3 - 1	
			var y:int = i/3 - 1
			var posi:Vector2i = Vector2i(x,y)
			var tilemap:TileMapLayer = gameplay_scene.piece_manager.tilemap
			var new_pos:Vector2i = posi + pos
			tilemap.set_cell(new_pos,0,Vector2i(-1,-1))
