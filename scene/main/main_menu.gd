extends Node2D


func _on_button_pressed() -> void:
	
	_change_scene()


func _on_play_lan_pressed() -> void:
	GameSettings.is_lan_mode = true
	_change_scene()

func _change_scene()->void:
	get_tree().change_scene_to_file("res://scene/gameplay_scene/gameplay.tscn")
