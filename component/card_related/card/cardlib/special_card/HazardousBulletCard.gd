extends CardStrategyPattern
class_name HazardousBulletCard

func get_rarity()->int:
	return 3 #1 to 5
	
func get_card_name()->String:
	return "Hazardous Bullet"
	
func get_description()->String:
	return "Either you die or your opponent"
	
func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var black_piece_array:Array[int] = []
	var white_piece_array:Array[int] = []
	var count:int = 0
	for child:Piece in piece_manager.get_children():
		if child.visible:
			if child.rank_of_the_piece != 5:
				if child.is_black:
					black_piece_array.append(count)
				else:
					white_piece_array.append(count)
		count += 1
	if len(black_piece_array) == 0 or len(white_piece_array) == 0:
		_do_reverse_not_activatable(gameplay_scene)
	else:
		var rando:int = gameplay_scene.get_randint(0,1)
		var to_kill:int
		if rando == 0:
			var black_sacrifice:int = get_random_piece(black_piece_array,gameplay_scene)
			to_kill = black_sacrifice
		else:
			var white_sacrifice:int = get_random_piece(white_piece_array,gameplay_scene)
			to_kill = white_sacrifice
		_kill_piece(to_kill,piece_manager)
	
func get_random_piece(array:Array[int],gameplayscene:GameplayScene)->int:
	seed(gameplayscene.get_randint(0,1000))
	return array.pick_random()
	
	
func _kill_piece(piece_index:int,piece_manager:PieceManager)->void:
	EventListenner.emit_signal("PieceTaken",piece_index,piece_manager.array_pos[piece_index])
	piece_manager._make_dead(piece_index)
	
	
func _custom_reverse(_to_x:int,_to_y:int,_is_black:bool,_gameplay_scene:GameplayScene)->void:
	pass
