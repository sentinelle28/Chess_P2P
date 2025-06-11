extends DestroyBoardCardStrategyPattern
class_name DestroyThreeCard

func get_num_to_destroy()->int:
	return 3
	
func get_card_name()->String:
	return "Earthquake"
	
func get_description()->String:
	return "Destroy 3 board tile"
	
func get_rarity()->int:
	return 2 #1 to 5
