extends Area2D
class_name Piece
@export var mouvement_option:Array[int]
@export var rank_of_the_piece:int = 0
@export var is_black:bool = true
@export var image_to_load:Texture2D
var is_selected:bool = false

func _ready() -> void:
	var sprite:Sprite2D = get_node("Sprite2D")
	sprite.texture = image_to_load
	sprite.hframes = 6
	sprite.frame_coords.x = rank_of_the_piece

func get_possible_mouvement()->Array[Vector2i]:
	var array:Array[Vector2i] = []
	var index:int = get_index()
	var parent:PieceManager = get_parent()
	for option:int in mouvement_option:
		if MouvRef.get_mouv(option) is ComputeMouvOption:
			var computemouv:ComputeMouvOption = MouvRef.get_mouv(option)
			var temp_array:Array[Vector2i] = computemouv.get_compute_possible_mouv(
				parent.tilemap,
				parent.array_pos[get_index()],
				parent.array_pos)
			array.append_array(temp_array)
		else:
			for possible_mouv:Vector2i in MouvRef.get_mouv(option).get_possible_mouv():
				if parent.is_in_map(possible_mouv,index):
					array.append(possible_mouv)
	return array

func _draw() -> void:
	if is_selected:
		var array:Array[Vector2i] = get_possible_mouvement()
		var parent:PieceManager = get_parent()
		parent.possible_pos.clear()
		
		#add for easier selection
		for pos:Vector2i in array:
			parent.possible_pos.append(pos + parent.array_pos[get_index()])
		
		#draw screen
		for possible_pos:Vector2i in array:
			draw_circle(possible_pos*20,5,Color.GRAY,true)
