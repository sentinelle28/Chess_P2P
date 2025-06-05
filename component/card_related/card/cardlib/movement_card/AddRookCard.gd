extends AddMovementCard
class_name AddRookCard
func get_card_name()->String:
	return "Rookification"
	
func get_description()->String:
	return "Add rook movement to a piece"
	



func get_mouv_to_add()->int:
	return 4

func get_rarity()->int:
	return 2 #1 to 5
