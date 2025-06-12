extends StatusCard
class_name CharmedCard
func get_card_name()->String:
	return "Charmed"
	
func get_description()->String:
	return "Control this piece next turn"
	
func get_rarity()->int:
	return 2 #1 to 5
	
func get_status_to_apply()->StatutStrategyPattern:
	return CharmedStatus.new()
