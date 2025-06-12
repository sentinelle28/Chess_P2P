extends DestroyBoardCardStrategyPattern
class_name DestroyOneCard

func get_num_to_destroy()->int:
	return 1
	
func get_card_name()->String:
	return "Pit"
	
func get_description()->String:
	return "Destroy a board tile"

func get_rarity()->int:
	return 2 #1 to 5
