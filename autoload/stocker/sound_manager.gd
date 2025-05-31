extends AudioStreamPlayer

func _ready() -> void:
	_set_sound_level()

func _set_sound_level()->void:
	volume_db = GameSettings.volume


func _on_finished() -> void:
	play()
