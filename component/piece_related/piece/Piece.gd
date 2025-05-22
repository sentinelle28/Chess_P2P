extends Area2D
class_name Piece
@export var mouvement_option:Array[int]
@export var rank_of_the_piece:int = 0
@export var is_black:bool = true
@export var pos:Vector2i
@export var image_to_load:Texture2D
var is_selected:bool = false

func _ready() -> void:
	var sprite:Sprite2D = get_node("Sprite2D")
	sprite.texture = image_to_load
	sprite.hframes = 6
	sprite.frame_coords.x = rank_of_the_piece

func get_possible_mouvement()->Array[Vector2i]:
	var array:Array[Vector2i] = []
	for option:int in mouvement_option:
		array.append_array(
			MouvRef.get_mouv(option).get_possible_mouv()
			)
	return array

func _draw() -> void:
	if is_selected:
		var array:Array[Vector2i] = get_possible_mouvement()
		for possible_pos:Vector2i in array:
			draw_circle(possible_pos*20,5,Color.GRAY,true)
