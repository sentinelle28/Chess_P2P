extends Node2D


@onready var main_menu:CanvasLayer = $Main_menu
@onready var setting_menu:CanvasLayer = $Settings

@export var main_music_bar:HSlider
@export var sfx_music_bar:HSlider

func _on_button_pressed() -> void:
	_change_scene()


func _on_play_lan_pressed() -> void:
	GameSettings.is_lan_mode = true
	_change_scene()

func _change_scene()->void:
	get_tree().change_scene_to_file("res://scene/gameplay_scene/gameplay.tscn")


func _on_setting_button_pressed() -> void:
	main_menu.hide()
	setting_menu.show()

func _on_quit_setting_pressed() -> void:
	main_menu.show()
	setting_menu.hide()


func _on_main_music_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		var new_value:float = main_music_bar.value
		var rap:float = new_value/100.0
		GameSettings.volume = (-80) * int(1.-rap)
		SoundManager._set_main_sound_level()


func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		pass
