extends SummonCardTemplate
class_name SummonQueen

func get_card_name()->String:
	return "His lady"
	
func get_description()->String:
	return "Summon 1 queen"
	
func get_cost()->int:
	return 5
	
func get_piece_to_summon()->int:
	return 4
	
func get_num_to_summon()->int:
	return 1
