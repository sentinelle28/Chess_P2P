extends DestroyBoardCardStrategyPattern
class_name DestroynineCard

func get_num_to_destroy()->int:
	return 9
	
func get_card_name()->String:
	return "Rift"
	
func get_description()->String:
	return "Destroy 9 board tile"

func get_rarity()->int:
	return 4 #1 to 5
