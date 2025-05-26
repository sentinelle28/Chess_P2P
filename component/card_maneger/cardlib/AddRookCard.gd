extends AddMovementCard
class_name AddRookCard
func get_card_name()->String:
	return "Rookification"
	
func get_description()->String:
	return "Add rook movement to a piece"
	
func get_rarity()->int:
	return 5
	
func get_cost()->int:
	return 1

func get_mouv_to_add()->int:
	return 4
