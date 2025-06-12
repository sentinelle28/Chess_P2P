extends StatutStrategyPattern
class_name LightningStatus
func _c_ready()->void:
	turn_left = 3
	var parent:Piece = get_parent()
	parent.monitorable = false
	
func _quit_procedure()->void:
	var parent:Piece = get_parent()
	parent.monitorable = true

func _reset_status()->void:
	var parent:Piece = get_parent()
	parent.monitorable = true
