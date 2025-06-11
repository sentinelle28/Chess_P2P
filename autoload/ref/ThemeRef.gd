extends Node


var array_of_theme:Array[String] = ["panel","Uncommon","rare","epic","legendary"]

#shader reference
var pre_shader:Shader = preload("res://asset/godot_assset/shader/SelectedShader.gdshader")
var could_be_selected_shader:Shader = preload("res://asset/godot_assset/shader/CouldBeSelected.gdshader")
var legendary_shader:Shader = preload("res://asset/godot_assset/shader/CardRarityVisualEffect.gdshader")


#image ref
var black_piece_ref:CompressedTexture2D = preload("res://asset/visual/pixel chess_v1.2/16x16 pieces/BlackPieces.png")
var white_piece_ref:CompressedTexture2D = preload("res://asset/visual/pixel chess_v1.2/16x16 pieces/WhitePieces.png")
