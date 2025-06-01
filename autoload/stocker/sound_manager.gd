extends AudioStreamPlayer

func _ready() -> void:
	_set_main_sound_level()

func _set_main_sound_level()->void:
	volume_db = GameSettings.volume

func _set_sfx_sound_level()->void:
	pass


func _on_finished() -> void:
	play()
