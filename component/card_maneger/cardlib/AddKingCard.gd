extends AddMovementCard
class_name AddKingCard
func get_card_name()->String:
	return "Coronation"
	
func get_description()->String:
	return "Add king movement to a piece"
	

	
func get_cost()->int:
	return 1

func get_mouv_to_add()->int:
	return 1
