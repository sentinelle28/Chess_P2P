extends SelectPieceCard
class_name BanCard
func _piece_activate(piece:int,_pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager = gameplay_scene.piece_manager
	var place_to_be_ban:Array[Vector2i] = [Vector2i(-18,-10),Vector2i(17,-10),Vector2i(17,5),Vector2i(-18,5)]
	for place:Vector2i in place_to_be_ban:
		if not piece_manager.is_valid_tile(place):
			place_to_be_ban.erase(place)
				
	if len(place_to_be_ban) == 0:
		_do_reverse_not_activatable(gameplay_scene)
	else:
		seed(gameplay_scene.get_randint(0,1000))
		var place_to_go:Vector2i = place_to_be_ban.pick_random()
		piece_manager._update_pos(piece,place_to_go,true)
		
		
		
func get_card_name()->String:
	return "Ban"
	
func get_description()->String:
	return "Ban a piece to a corner"
	
func get_rarity()->int:
	return 2 #1 to 5
