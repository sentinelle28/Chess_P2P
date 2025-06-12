extends StatusCard
class_name LightningCard
func get_card_name()->String:
	return "Stun"
	
func get_description()->String:
	return "Stun a piece for 3 turn"
	
func get_rarity()->int:
	return 2 #1 to 5
	
func get_status_to_apply()->StatutStrategyPattern:
	return LightningStatus.new()
