extends Area2D
class_name Player
var last_selected_piece:Piece
var is_black:bool = false
@onready var anim:AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta: float) -> void:
	var mouse_pos:Vector2 = get_global_mouse_position()
	global_position.x = mouse_pos.x
	global_position.y = mouse_pos.y
	
func can_click()->bool:
	return is_instance_valid(last_selected_piece)
	


func _on_area_entered(area: Area2D) -> void:
	if area is Piece:
		if area.is_black == is_black:
			last_selected_piece = area
			anim.play("can_click")
			area.is_selected = true
			area.queue_redraw()


func _on_area_exited(area: Area2D) -> void:
	if area is Piece:
		last_selected_piece = null
		anim.play("idle")
		area.is_selected = false
		area.queue_redraw()
