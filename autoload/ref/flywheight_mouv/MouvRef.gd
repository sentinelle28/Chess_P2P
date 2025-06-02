extends Node
var array_of_mouv:Array[MouvementOption] = [
	load("res://instance/mouvement_lib/Beashop.tres"),
	load("res://instance/mouvement_lib/King.tres"),
	load("res://instance/mouvement_lib/Knight.tres"),
	load("res://instance/mouvement_lib/Pawn.tres"),
	load("res://instance/mouvement_lib/Rook.tres")
]

var pre_shader:Shader = preload("res://asset/godot_assset/shader/SelectedShader.gdshader")
var could_be_selected_shader:Shader = preload("res://asset/godot_assset/shader/CouldBeSelected.gdshader")


func get_mouv(index:int)->MouvementOption:
	return array_of_mouv[index]
