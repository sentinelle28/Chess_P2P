extends AddMovementCard
class_name AddRandomMove

func get_card_name()->String:
	return "Beer"
	
func get_description()->String:
	return "Give a strange move to a piece"
	
func get_mouv_to_add()->int:
	return 5

func get_rarity()->int:
	return 3 #1 to 5
