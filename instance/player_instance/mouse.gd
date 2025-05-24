extends Area2D
class_name Player
var last_selected_piece:Piece
var is_black:bool = false
var can_play:bool = false
var is_lock_on_piece:bool = false
@onready var anim:AnimatedSprite2D = $AnimatedSprite2D
signal mouv_input(who:int)

func _ready() -> void:
	EventListenner.connect("DidAction",_prevent_futher_action)


func _process(_delta: float) -> void:
	var mouse_pos:Vector2 = get_global_mouse_position()
	global_position.x = mouse_pos.x
	global_position.y = mouse_pos.y
	if is_instance_valid(last_selected_piece) and not is_instance_valid(EventListenner.action):
		if not is_lock_on_piece:
			_select_input()
		else:
			_mouv_input()
	
func _select_input()->void:
	if Input.is_action_just_pressed("select"):
		is_lock_on_piece = true
		anim.play("click")
		
func _mouv_input()->void:
	if Input.is_action_just_pressed("select"):
		emit_signal("mouv_input",last_selected_piece.get_index())
		_exit_piece(last_selected_piece)
		_reset()
	
func can_click()->bool:
	return is_instance_valid(last_selected_piece)
	


func _on_area_entered(area: Area2D) -> void:
	if area is Piece:
		if can_play and area.is_black == is_black and not is_lock_on_piece:
			last_selected_piece = area
			anim.play("can_click")
			area.is_selected = true
			area.queue_redraw()


func _on_area_exited(area: Area2D) -> void:
	if area is Piece and not is_lock_on_piece:
		last_selected_piece = null
		_exit_piece(area)

func _reset()->void:
	is_lock_on_piece = false
	last_selected_piece = null

func _exit_piece(piece:Piece)->void:
	anim.play("idle")
	piece.is_selected = false
	piece.queue_redraw()

func _prevent_futher_action()->void:
	can_play = false
