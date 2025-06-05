extends SummonCardTemplate
class_name SummonBeashop
func get_card_name()->String:
	return "Prayer"
	
func get_description()->String:
	return "Summon 1 beashop"
	

	
func get_piece_to_summon()->int:
	return 0
	
func get_num_to_summon()->int:
	return 1

func get_rarity()->int:
	return 2 #1 to 5
