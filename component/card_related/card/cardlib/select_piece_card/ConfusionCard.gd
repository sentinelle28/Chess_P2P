extends SelectPieceCard
class_name ConfusionCard

func get_rarity()->int:
	return 2 #1 to 5
	
func get_card_name()->String:
	return "Confusion"
	
func get_description()->String:
	return "Make a piece moves randomly"
	
func _piece_activate(piece:int,pos:Vector2i,_is_black:bool,gameplay_scene:GameplayScene)->void:
	var piece_manager:PieceManager = gameplay_scene.piece_manager
	var previous_pos:Vector2i = pos
	var new_pos:Vector2i = previous_pos + Vector2i(gameplay_scene.get_randint(-1,1),gameplay_scene.get_randint(-1,1))
	
	piece_manager._update_pos(piece,new_pos,true)
	
