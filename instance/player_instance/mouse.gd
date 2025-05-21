extends Area2D

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		var mouse_pos:Vector2 = get_global_mouse_position()
		global_position.x = lerpf(global_position.x,mouse_pos.x,delta)
		global_position.y = lerpf(global_position.y,mouse_pos.y,delta)
