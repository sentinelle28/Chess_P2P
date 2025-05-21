extends Node2D
var peer:ENetMultiplayerPeer

func _host() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(7000,2)
	multiplayer.multiplayer_peer = peer
	_hide()
	
func _join()->void:
	if is_instance_valid(peer):
		peer = ENetMultiplayerPeer.new()
		peer.create_client(IP.get_local_addresses()[0],7000)
		multiplayer.multiplayer_peer = peer
		_hide()
	else:
		_host()
	

func _hide()->void:
	$Host.hide()
	$Join.hide()
