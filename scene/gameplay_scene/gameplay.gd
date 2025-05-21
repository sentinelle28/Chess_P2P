extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var playerscene:PackedScene
@export var internet_related:Control
#@export var inputext:TextEdit
const PORT:int = 135
const MAX_PLAYER:int = 2



func _on_host_pressed()->void:
	peer.create_server(PORT,MAX_PLAYER)
	multiplayer.multiplayer_peer = peer
	_add_player(1)
	_hide_UI()
	
func _hide_UI()->void:
	internet_related.hide()

func _on_join_pressed()->void:
	peer.create_client(IP.get_local_addresses()[1],PORT)
	print("connected to: ", IP.get_local_addresses()[1])
	multiplayer.multiplayer_peer = peer
	_add_player(2)
	_hide_UI()

func _add_player(id:int)->void:
	var player = playerscene.instantiate()
	player.name = str(id)
	print("created player with id:", id)
	player.set_multiplayer_authority(id)
	call_deferred("add_child",player)
