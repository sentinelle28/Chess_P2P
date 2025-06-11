extends AudioStreamPlayer

func _ready() -> void:
	_set_main_sound_level()
	_set_sfx_sound_level()

func _set_main_sound_level()->void:
	volume_db = GameSettings.volume

func _set_sfx_sound_level()->void:
	for child:AudioStreamPlayer in get_children():
		if child.name == "Click":
			child.volume_db = GameSettings.sfx_volume - 8.
		else:
			child.volume_db = GameSettings.sfx_volume - 2.


func _on_finished() -> void:
	play()
	
func _play_sfx(name_of_the_sfx:String)->void:
	var audio:AudioStreamPlayer = get_node(name_of_the_sfx)
	audio.play()
