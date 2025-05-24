extends Node
class_name PieceManager


@export var tilemap:TileMapLayer
var array_pos:Array[Vector2i] = []
var possible_pos:Array[Vector2i] = []


func _ready() -> void:
	_reset()
		
func _reset()->void:
	array_pos.clear()
	for i:int in range(32):
		var child:Piece = get_child(i)
		array_pos.append(PosReset.beginning_pos[i])
		child.global_position = get_map_pos(PosReset.beginning_pos[i])
		child.show()
		child.monitorable = true
	
func _update_pos(index:int,value:Vector2i)->void:
	#check if there has been a kill
	if value in array_pos and value != array_pos[index]:
		var index_of_the_victim:int = array_pos.find(value)
		EventListenner.emit_signal("PieceTaken",index_of_the_victim)
		_make_dead(index_of_the_victim)
	
	
	array_pos[index] = value
	var child:Piece = get_child(index)
	child.global_position = get_map_pos(value)

func get_map_pos(pos:Vector2i)->Vector2:
	var pos_local:Vector2 = tilemap.map_to_local(pos)
	var global_pos:Vector2 = tilemap.to_global(pos_local)
	return global_pos
	
func _make_dead(index:int)->void:
	var child:Piece = get_child(index)
	child.hide()
	child.monitorable = false
	
func _make_alive(index:int)->void:
	var child:Piece = get_child(index)
	child.show()
	child.monitorable = true

func is_in_map(pos:Vector2i,index:int)->bool:
	var posi:Vector2i = array_pos[index]
	var true_pos:Vector2i = pos+posi
	return tilemap.get_cell_atlas_coords(true_pos) != Vector2i(-1,-1)
	

func _check_mouse_pos(who:int)->void:
	var mouse_pos:Vector2 = tilemap.get_local_mouse_position()
	var tile_pos:Vector2i = tilemap.local_to_map(mouse_pos)
	if tile_pos in possible_pos:
		#created the sucequent action
		EventListenner.emit_signal("PieceMov",array_pos[who],tile_pos,who)
		
		#update pos and check if there has been a piece takenb
		_update_pos(who,tile_pos)
		#clear possible pos since it is not usefull
		possible_pos.clear()
	
