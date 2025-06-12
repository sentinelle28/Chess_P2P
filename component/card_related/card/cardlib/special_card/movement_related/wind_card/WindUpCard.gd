extends WindCardStrategyPattern
class_name WindUpCard
func get_card_name()->String:
	return "South Wind"
	
func get_description()->String:
	return "Make all oponenet piece move up"
	
func get_rarity()->int:
	return 1 #1 to 5

func get_direction()->Vector2i:
	return Vector2i(0,-1)
