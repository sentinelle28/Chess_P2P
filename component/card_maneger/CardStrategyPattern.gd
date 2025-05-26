extends Resource
class_name CardStrategyPattern

var index:int = 0

func get_card_name()->String:
	return "Template"
	
func get_description()->String:
	return "None"
	
func get_rarity()->int:
	return 0
	
func get_cost()->int:
	return 0

func _apply(to_x:int,to_y:int,is_black:bool,piece_manager:PieceManager)->void:
	pass

func _reverse(to_x:int,to_y:int,is_black:bool,piece_manager:PieceManager)->void:
	pass
