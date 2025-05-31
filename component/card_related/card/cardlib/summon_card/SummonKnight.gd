extends SummonCardTemplate
class_name SummonKnight

func get_card_name()->String:
	return "Call Knight"
	
func get_description()->String:
	return "Summon 2 knight"
	

	
func get_piece_to_summon()->int:
	return 2
	
func get_num_to_summon()->int:
	return 2
