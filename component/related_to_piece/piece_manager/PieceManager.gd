extends Node
class_name PieceManager

signal Victory(is_black:bool) #send when one king is captured
signal PosVerified(pos:Vector2i,is_black:bool) # emited to card manager
signal StopQueuing # emited to prevent mouse seeking the same thing over and over again

@export var tilemap:TileMapLayer
var array_pos:Array[Vector2i] = []
var possible_pos:Array[Vector2i] = []


func _ready() -> void:
	connect("Victory",get_parent()._do_victory)
		
func _reset()->void:
	array_pos.clear()
	var to_delete:Array[Piece] = []
	for i:int in range(get_child_count()):
		if i <= 31: #0 à 32
			var child:Piece = get_child(i)
			array_pos.append(PosReset.beginning_pos[i])
			child.global_position = get_map_pos(PosReset.beginning_pos[i])
			_reset_piece(child)
		else:
			# there is too many children
			to_delete.append(get_child(i))
	for piece:Piece in to_delete:
		remove_child(piece)
	to_delete.clear()
	
func _reset_piece(piece:Piece)->void:
	piece.show()
	piece.monitorable = true
	var color:bool = "Black" in piece.name
	piece.is_black = color
	var array_of_piece_rank:Array[String] = ["Pawn","Knight","Rook","Beashop","Queen","King"]
	var current_piece_name:String = piece.name
	if color:
		current_piece_name = current_piece_name.split("Black")[1]
	else:
		current_piece_name = current_piece_name.split("White")[1]
		
	piece._update_frame_coords(piece.rank_of_the_piece)
	
	
	
func _update_pos(index:int,value:Vector2i,do_emit_signal:bool)->void:
	SoundManager._play_sfx("MovePiece")
	if do_emit_signal:
		SoundManager._play_sfx("TookPiece")
		EventListenner.emit_signal("PieceMov",array_pos[index],value,index)
	#check if there has been a kill
	if value in array_pos and value != array_pos[index]:
		var index_of_the_victim:int = array_pos.find(value)
		EventListenner.emit_signal("PieceTaken",index_of_the_victim,array_pos[index_of_the_victim])
		_make_dead(index_of_the_victim)
		var piece:Piece = get_child(index_of_the_victim)
		if "King" in piece.name:
			emit_signal("Victory",not piece.is_black)
	
	
	array_pos[index] = value
	var child:Piece = get_child(index)
	var temp:Tween = get_tree().create_tween()
	temp.tween_property(child,"global_position",get_map_pos(value),0.5)

func get_map_pos(pos:Vector2i)->Vector2:
	var pos_local:Vector2 = tilemap.map_to_local(pos)
	var global_pos:Vector2 = tilemap.to_global(pos_local)
	return global_pos
	
func _make_dead(index:int)->void:
	var child:Piece = get_child(index)
	child.global_position = get_map_pos(Vector2i(-19,-11))
	child.hide()
	child.monitorable = false
	
func _make_alive(index:int,pos:Vector2i)->void:
	var child:Piece = get_child(index)
	child.global_position = get_map_pos(pos)
	child.show()
	child.monitorable = true

func is_in_map(pos:Vector2i,index:int)->bool:
	var posi:Vector2i = array_pos[index]
	var true_pos:Vector2i = pos+posi
	return tilemap.get_cell_atlas_coords(true_pos) != Vector2i(-1,-1)
	

func _check_mouse_pos(who:int)->void:
	var tile_pos:Vector2i = get_mouse_pos()
	if tile_pos in possible_pos:
		#update pos and check if there has been a piece takenb
		_update_pos(who,tile_pos,true)
		#clear possible pos since it is not usefull
		possible_pos.clear()

func get_mouse_pos()->Vector2i:
	var mouse_pos:Vector2 = tilemap.get_local_mouse_position()
	var tile_pos:Vector2i = tilemap.local_to_map(mouse_pos)
	return tile_pos
	
func _verify_card_pos(is_black:bool)->void:
	var pos:Vector2i = get_mouse_pos()
	if tilemap.get_cell_atlas_coords(pos) != Vector2i(-1,-1):
		emit_signal("PosVerified",pos,is_black)
	#mouse doesn't need after that to wait for input
	emit_signal("StopQueuing")
	
func _add_piece(piece:Piece,pos:Vector2i)->void:
	add_child(piece)
	piece.global_position = get_map_pos(pos)
	array_pos.append(pos)
	piece.scale = Vector2(1.6,1.6)

func _add_shader_to_piece(shader:Shader)->void:
	for child:Piece in get_children():
		child._add_shader(shader)
		
func _remove_shader()->void:
	for child:Piece in get_children():
		child._remove_shader()
		
