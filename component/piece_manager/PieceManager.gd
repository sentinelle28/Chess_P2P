extends Node
class_name PieceManager


@export var tilemap:TileMapLayer
var array_pos:Array[Vector2i] = []

func _ready() -> void:
	_reset()
		
func _reset()->void:
	array_pos.clear()
	for i:int in range(get_child_count()):
		var child:Piece = get_child(i)
		array_pos.append(PosReset.beginning_pos[i])
		child.global_position = get_map_pos(PosReset.beginning_pos[i])
		child.show()
		child.monitorable = true
	
func _update_pos(index:int,value:Vector2i)->void:
	array_pos[index] = value

func get_map_pos(pos:Vector2i)->Vector2:
	var pos_local:Vector2 = tilemap.map_to_local(pos)
	var global_pos:Vector2 = tilemap.to_global(pos_local)
	return global_pos
	
func _make_dead(index:int)->void:
	var child:Piece = get_child(index)
	child.hide()
	child.monitorable = false

func is_in_map(pos:Vector2i,index:int)->bool:
	var posi:Vector2i = array_pos[index]
	var true_pos:Vector2i = pos+posi
	return tilemap.get_cell_atlas_coords(true_pos) != Vector2i(-1,-1)
	
