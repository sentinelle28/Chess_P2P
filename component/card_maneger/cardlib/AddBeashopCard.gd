extends AddMovementCard
class_name AddBeashopCard

func get_card_name()->String:
	return "Priest in training"
	
func get_description()->String:
	return "Add beashop movement to a piece"
	

	
func get_cost()->int:
	return 1

func get_mouv_to_add()->int:
	return 0
