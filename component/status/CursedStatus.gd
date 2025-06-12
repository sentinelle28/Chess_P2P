extends StatutStrategyPattern
class_name CursedStatus
func _c_ready()->void:
	turn_left = 3

func _quit_procedure()->void:
	var scene:GameplayScene = get_tree().current_scene
	var current_index:int = get_parent().get_index()
	scene.piece_manager._make_dead(current_index)
