extends Node
var array_of_mouv:Array[MouvementOption] = [
	load("res://instance/mouvement_lib/Beashop.tres"),
	load("res://instance/mouvement_lib/King.tres"),
	load("res://instance/mouvement_lib/Knight.tres"),
	load("res://instance/mouvement_lib/Pawn.tres"),
	load("res://instance/mouvement_lib/Rook.tres")
]

#shader reference
var pre_shader:Shader = preload("res://asset/godot_assset/shader/SelectedShader.gdshader")
var could_be_selected_shader:Shader = preload("res://asset/godot_assset/shader/CouldBeSelected.gdshader")

#image ref
var black_piece_ref:CompressedTexture2D = preload("res://asset/visual/pixel chess_v1.2/16x16 pieces/BlackPieces.png")
var white_piece_ref:CompressedTexture2D = preload("res://asset/visual/pixel chess_v1.2/16x16 pieces/WhitePieces.png")

func get_mouv(index:int)->MouvementOption:
	return array_of_mouv[index]
