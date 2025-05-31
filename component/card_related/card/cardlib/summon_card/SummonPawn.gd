extends SummonCardTemplate
class_name SummonPawn

func get_card_name()->String:
	return "Renforcement"
	
func get_description()->String:
	return "Summon 3 pawn"


	
func get_piece_to_summon()->int:
	return 3
	
func get_num_to_summon()->int:
	return 3
