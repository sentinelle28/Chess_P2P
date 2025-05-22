extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var playerscene:PackedScene
@export var internet_related:Control
#@export var inputext:TextEdit
const PORT:int = 135
const MAX_PLAYER:int = 2
var m_player:Player
var is_two:bool = false

@onready var action:VBoxContainer = $UI_related/UI/HBoxContainer/Action/InMatch

func _on_host_pressed()->void:
	peer.create_server(PORT,MAX_PLAYER)
	multiplayer.multiplayer_peer = peer
	multiplayer.connect("peer_connected",_update_peer)
	_add_player(1)
	_hide_UI()
	
func _update_peer(_value:int)->void:
	is_two = true
	
func _hide_UI()->void:
	internet_related.hide()
	

func _on_join_pressed()->void:
	peer.create_client(IP.get_local_addresses()[1],PORT)
	print("connected to: ", IP.get_local_addresses()[1])
	multiplayer.multiplayer_peer = peer
	_add_player(2)
	_hide_UI()
	$UI_related/UI/HBoxContainer/Action/Start.hide()
	

func _add_player(id:int)->void:
	var player = playerscene.instantiate()
	player.name = str(id)
	print("created player with id:", id)
	player.set_multiplayer_authority(id)
	call_deferred("add_child",player)
	m_player = player


func _on_start_pressed() -> void:
	if is_two:
		$UI_related/UI/HBoxContainer/Action/Start.hide()
		var is_black:bool = randi_range(0,1) == 1
		var is_starting:bool = randi_range(0,1) == 1
		action.visible = is_starting
		m_player.is_black = is_black
		
		_change_color(is_black)
		rpc("_start_game", not is_starting, not is_black)

func is_peer_connected()->bool:
	return get_multiplayer().peer.is_active()

func _change_color(is_black:bool)->void:
	if is_black:
		$UI_related/UI/HBoxContainer/Play/ColorRect.color = Color.BLACK

@rpc("call_remote","authority")
func _start_game(is_starting:bool,is_black:bool)->void:
	
	action.visible = is_starting
	m_player.is_black = is_black
	_change_color(is_black)
