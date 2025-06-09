extends Node
var array_of_piece:Array[PackedScene] = [
	preload("res://instance/piece_instance/Piece_lib/beashop.tscn"), #0
	preload("res://instance/piece_instance/Piece_lib/king.tscn"), #1
	preload("res://instance/piece_instance/Piece_lib/knight.tscn"), #2
	preload("res://instance/piece_instance/Piece_lib/pawn.tscn"), #3
	preload("res://instance/piece_instance/Piece_lib/queen.tscn"), #4
	preload("res://instance/piece_instance/Piece_lib/rook.tscn"), #5
	
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
	piece.is_black = is_black
	return piece
