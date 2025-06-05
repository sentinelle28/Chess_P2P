extends SummonCardTemplate
class_name SummonRook
func get_card_name()->String:
	return "Enots"
	
func get_description()->String:
	return "Summon 1 rook"
	

	
func get_piece_to_summon()->int:
	return 5
	
func get_num_to_summon()->int:
	return 1

func get_rarity()->int:
	return 2 #1 to 5
