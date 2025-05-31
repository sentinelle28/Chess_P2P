extends Resource
class_name CardStrategyPattern

var index:int = 0

func get_card_name()->String:
	return "Template"
	
func get_description()->String:
	return "None"
	
func get_cost()->int:
	return 2

func _apply(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	pass

func _reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	var card_manager:CardManager = gameplay_scene.card_manager
	card_manager.current_card.append(CardLib.array_of_card[index])
	card_manager.current_energy += get_cost()
	card_manager._update_card()
	
	_custom_reverse(to_x,to_y,is_black,gameplay_scene)

func _custom_reverse(to_x:int,to_y:int,is_black:bool,gameplay_scene:GameplayScene)->void:
	pass
	
	
