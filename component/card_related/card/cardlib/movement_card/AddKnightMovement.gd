extends AddMovementCard
class_name AddKnightMovement


func get_card_name()->String:
	return "Knighthood"
	
func get_description()->String:
	return "Add knight movement to a piece"
	


func get_mouv_to_add()->int:
	return 2
