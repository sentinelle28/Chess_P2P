extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var playerscene:PackedScene
@export var internet_related:Control
#@export var inputext:TextEdit
const PORT:int = 135
const MAX_PLAYER:int = 2
var m_player:Player
var is_two:bool = false

@onready var action_bar:VBoxContainer = $UI_related/UI/bottom_box/action/InMatch

func _on_host_pressed()->void:
	peer.create_server(PORT,MAX_PLAYER)
	multiplayer.multiplayer_peer = peer
	multiplayer.connect("peer_connected",_update_peer)
	_add_player(1)
	_hide_UI()
	
func _update_peer(_value:int)->void:
	is_two = true
	$UI_related/UI/bottom_box/action/Start.show()
	
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
	player.set_multiplayer_authority(id)
	call_deferred("add_child",player)
	m_player = player
	#check if mouse clicked somewhere good
	m_player.connect("mouv_input",$PieceManager._check_mouse_pos)


func _on_start_pressed() -> void:
	if is_two:
		$UI_related/UI/bottom_box/action/Start.hide()
		var is_black:bool = randi_range(0,1) == 1
		var is_starting:bool = randi_range(0,1) == 1
		action_bar.visible = is_starting
		m_player.is_black = is_black
		m_player.can_play = is_starting
		_change_color(is_black)
		rpc("_start_game", not is_starting, not is_black)

func is_peer_connected()->bool:
	return get_multiplayer().peer.is_active()

func _change_color(is_black:bool)->void:
	if is_black:
		$UI_related/UI/bottom_box/Play/ColorRect.color = Color.WHITE
		$UI_related/UI/bottom_box/Play/BlackKing.show()
		$UI_related/UI/bottom_box/Play/WhiteKing.hide()
	else:
		$UI_related/UI/bottom_box/Play/ColorRect.color = Color.BLACK
		$UI_related/UI/bottom_box/Play/BlackKing.hide()
		$UI_related/UI/bottom_box/Play/WhiteKing.show()

@rpc("call_remote","authority")
func _start_game(is_starting:bool,is_black:bool)->void:
	action_bar.visible = is_starting
	m_player.can_play = is_starting
	m_player.is_black = is_black
	_change_color(is_black)


@rpc("authority","call_remote")
func _do_action_client(action:Action)->void:
	_do_action(action)
	
@rpc("any_peer","call_local")
func _do_action_host(action:Action)->void:
	_do_action(action)
	#need to rework how to send custom object over internet
		
		
		
func _do_action(action:Action)->void:
	if action is MouvAction:
		action._do_action($PieceManager)
	EventListenner.consequences.clear()
	action_bar.show()

func _do_consequence()->void:
	if EventListenner.did_action():
		m_player.can_play = true
		EventListenner._reset_action()
		for consequence:Consequence in EventListenner.consequences:
			if consequence is MouvConsequence:
				consequence._reverse($PieceManager)
			if consequence is PieceTakenConsequence:
				consequence._reverse($PieceManager)
	
func _send_action()->void:
	if EventListenner.did_action():
		EventListenner._reset_consequence()
		if is_multiplayer_authority():
			rpc("_do_action_client",EventListenner.get_action())
			EventListenner.action = null
		else:
			rpc("_do_action_host",EventListenner.get_action())
			EventListenner.action = null
			
		#prevent playing twice
		m_player.can_play = false
		action_bar.hide()
