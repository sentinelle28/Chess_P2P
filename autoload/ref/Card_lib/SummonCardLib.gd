extends Node
var array_of_piece:Array[PackedScene] = [
	preload("res://instance/piece_instance/Piece_lib/beashop.tscn"),
	preload("res://instance/piece_instance/Piece_lib/king.tscn"),
	preload("res://instance/piece_instance/Piece_lib/knight.tscn"),
	preload("res://instance/piece_instance/Piece_lib/pawn.tscn"),
	preload("res://instance/piece_instance/Piece_lib/queen.tscn"),
	preload("res://instance/piece_instance/Piece_lib/rook.tscn"),
	
]

@onready var white_piece_image:CompressedTexture2D = preload("res://asset/visual/pixel chess_v1.2/16x16 pieces/WhitePieces.png")
@onready var black_piece_image:CompressedTexture2D = preload("res://asset/visual/pixel chess_v1.2/16x16 pieces/BlackPieces.png")

var last_summon_array:Array[bool] = [
	false,false,false,
	false,false,false,
	false,false,false
	]

func _reset_last_summon_array()->void:
	last_summon_array = [
	false,false,false,
	false,false,false,
	false,false,false
	]


func get_piece(index:int,is_black:bool)->Piece:
	var piece:Piece = array_of_piece[index].instantiate()
	if is_black:
		piece.image_to_load = black_piece_image
	else:
		piece.image_to_load = white_piece_image
	piece.is_black = is_black
	return piece
