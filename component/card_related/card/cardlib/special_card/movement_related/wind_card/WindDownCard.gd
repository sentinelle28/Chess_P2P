extends WindCardStrategyPattern
class_name WindDownCard
func get_card_name()->String:
	return "North Wind"
	
func get_description()->String:
	return "Make all oponenet piece move down"
	
func get_rarity()->int:
	return 1 #1 to 5

func get_direction()->Vector2i:
	return Vector2i(-1,0)
