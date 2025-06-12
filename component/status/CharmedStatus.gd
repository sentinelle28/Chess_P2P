extends StatutStrategyPattern
class_name CharmedStatus
func _c_ready()->void:
	turn_left = 2
	var parent:Piece = get_parent()
	parent.is_black = not parent.is_black
	
func _quit_procedure()->void:
	var parent:Piece = get_parent()
	parent.is_black = not parent.is_black

func _reset_status()->void:
	var parent:Piece = get_parent()
	parent.is_black = not parent.is_black
