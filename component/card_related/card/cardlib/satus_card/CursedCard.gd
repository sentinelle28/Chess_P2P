extends StatusCard
class_name CursedCard
func get_card_name()->String:
	return "Curse"
	
func get_description()->String:
	return "This piece will die in 3 turn"
	
func get_rarity()->int:
	return 2 #1 to 5
	
func get_status_to_apply()->StatutStrategyPattern:
	return CursedStatus.new()
