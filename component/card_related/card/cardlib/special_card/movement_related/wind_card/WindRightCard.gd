extends WindCardStrategyPattern
class_name WindRightCard
func get_card_name()->String:
	return "West Wind"
	
func get_description()->String:
	return "Make all oponenet piece move right"
	
func get_rarity()->int:
	return 2 #1 to 5

func get_direction()->Vector2i:
	return Vector2i(1,0)
