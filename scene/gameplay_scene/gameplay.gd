extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var playerscene:PackedScene
@export var internet_related:Control
#@export var inputext:TextEdit
const PORT:int = 135
const MAX_PLAYER:int = 2
var m_player:Player
var is_two:bool = false
var is_replaying:bool = false

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

func _reset_global()->void:
	$UI_related/UI/bottom_box/action/Start.hide()
	$UI_related/Defeat.hide()
	$UI_related/Victory.hide()
	#reset
	m_player._reset()
	EventListenner._reset_action()
	EventListenner._reset_consequence()
	$PieceManager._reset()
	
@rpc("authority","call_remote")
func _reset_client()->void:
	_reset_global()

func _on_start_pressed() -> void:
	if is_two:
		#hide unuseful
		_reset_global()
		rpc("_reset_client")
		#who is gonna start
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

func _construct_mouv_action(who:int,to_x:int,to_y:int)->void:
	var new_action:MouvAction = MouvAction.new()
	new_action.index = who
	new_action.new_pos = Vector2i(to_x,to_y)
	_do_action(new_action)

@rpc("authority","call_remote")
func _do_mouv_action_client(who:int,to_x:int,to_y:int)->void:
	_construct_mouv_action(who,to_x,to_y)
	
@rpc("any_peer","call_local")
func _do_mouv_action_host(who:int,to_x:int,to_y:int)->void:
	if is_multiplayer_authority():
		_construct_mouv_action(who,to_x,to_y)
		
		
func _do_action(action:Action)->void:
	is_replaying = true
	if action is MouvAction:
		action._do_action($PieceManager)
	#prevent weird reset that doesn't make sens
	EventListenner.consequences.clear()
	#allow player to do action
	action_bar.show()
	m_player.can_play = true
	m_player.is_lock_on_piece = false
	is_replaying = false
	EventListenner.action = null
	print(is_multiplayer_authority()," can play")


func _do_consequence()->void:
	if EventListenner.did_action():
		m_player.can_play = true
		EventListenner._reset_action()
		for consequence:Consequence in EventListenner.consequences:
			if consequence is MouvConsequence:
				consequence._reverse($PieceManager)
			if consequence is PieceTakenConsequence:
				consequence._reverse($PieceManager)
		EventListenner._reset_consequence()
	
func _send_action()->void:
	if EventListenner.did_action():
		var action_to_send:Action = EventListenner.get_action()
		var to_add:String = "_host"
		#make sure we ask to update the right pc
		if is_multiplayer_authority():
			to_add = "_client"
		
		#send info as requiered
		if action_to_send is MouvAction:
			var to_call:String = "_do_mouv_action"+to_add
			print("action was sent from :",is_multiplayer_authority()," to: ",not is_multiplayer_authority())
			rpc(
				to_call, #mouv function
				action_to_send.index, #who to move
				action_to_send.new_pos.x, #where on x
				action_to_send.new_pos.y) #where on y
			
		EventListenner.action = null
			
		#prevent playing twice
		m_player.can_play = false
		m_player.is_lock_on_piece = false
		action_bar.hide()

func _do_victory(is_black:bool)->void:
	if is_multiplayer_authority():
		$UI_related/UI/bottom_box/action/Start.show()
	
	if not is_replaying:
		_send_action()
		var to_add:String = "_host"
		#make sure we ask to update the right pc
		if is_multiplayer_authority():
			to_add = "_client"
		rpc("_stop_action"+to_add)
		
	var result:bool = is_black == m_player.is_black
	$UI_related/Defeat.visible = not result
	$UI_related/Victory.visible = result


@rpc("any_peer","call_local")
func _stop_action_host()->void:
	if is_multiplayer_authority():
		action_bar.hide()
		m_player.can_play = false

@rpc("authority","call_remote")
func _stop_action_client()->void:
	action_bar.hide()
	m_player.can_play = false
