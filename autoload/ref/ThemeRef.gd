extends Node


var array_of_theme:Array[StyleBoxFlat] = [
	preload("res://asset/godot_assset/theme/card_theme/CommonCard.tres"),
	preload("res://asset/godot_assset/theme/card_theme/Uncommon.tres"),
	preload("res://asset/godot_assset/theme/card_theme/Rare.tres"),
	preload("res://asset/godot_assset/theme/card_theme/Epic.tres"),
	preload("res://asset/godot_assset/theme/card_theme/Legendary.tres")
]

#shader reference
var pre_shader:Shader = preload("res://asset/godot_assset/shader/SelectedShader.gdshader")
var could_be_selected_shader:Shader = preload("res://asset/godot_assset/shader/CouldBeSelected.gdshader")

#image ref
var black_piece_ref:CompressedTexture2D = preload("res://asset/visual/pixel chess_v1.2/16x16 pieces/BlackPieces.png")
var white_piece_ref:CompressedTexture2D = preload("res://asset/visual/pixel chess_v1.2/16x16 pieces/WhitePieces.png")
