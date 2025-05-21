extends Area2D

var last_selected_piece:Piece
@onready var anim:AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	var mouse_pos:Vector2 = get_global_mouse_position()
	global_position.x = lerpf(global_position.x,mouse_pos.x,delta)
	global_position.y = lerpf(global_position.y,mouse_pos.y,delta)
	
	
func can_click()->bool:
	return is_instance_valid(last_selected_piece)
	


func _on_area_entered(area: Area2D) -> void:
	if area is Piece:
		last_selected_piece = area
		anim.play("can_click")


func _on_area_exited(area: Area2D) -> void:
	last_selected_piece = null
	anim.play("idle")
