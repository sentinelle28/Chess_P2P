extends Node
class_name StatutStrategyPattern

var turn_left:int = 0

func _ready() -> void:
	var gameplay_scene:GameplayScene = get_tree().current_scene
	gameplay_scene.connect("NewTurn",_process_turn)
	_c_ready()
	
func _c_ready()->void:
	pass

func _process_turn()->void:
	turn_left -= 1
	if turn_left <= 0:
		_general_quit_procedure()
		
func _general_quit_procedure()->void:
	_quit_procedure()
	queue_free()
	
func _quit_procedure()->void:
	pass

func _reset_g_status()->void:
	_reset_status()
	queue_free()
	

func _reset_status()->void:
	pass
