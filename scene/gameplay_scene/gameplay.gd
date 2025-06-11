extends Node2D
class_name GameplayScene
var peer = ENetMultiplayerPeer.new()
@export_subgroup("To instantiate")
@export var playerscene:PackedScene
@export_subgroup("Usefull tool")
@export var internet_related:Control
@export var card_manager:CardManager
@export var piece_manager:PieceManager
@export var card_anim:CardAnim

const PORT:int = 135
const MAX_PLAYER:int = 2
var m_player:Player
var is_two:bool = false
var is_replaying:bool = false

var turn:int = 0

@onready var action_bar:VBoxContainer = $UI_related/UI/bottom_box/action/InMatch
@onready var particle:CPUParticles2D = $UI_related/CardUseInstance

signal NewTurn
signal EndTurn

func _ready() -> void:
	connect("NewTurn",card_manager._update_energy)
	connect("EndTurn",card_manager.hide)

func _on_host_pressed()->void:
	SoundManager._play_sfx("Click")
	peer.create_server(PORT,MAX_PLAYER)
	multiplayer.multiplayer_peer = peer
	multiplayer.connect("peer_disconnected",_disconnect)
	multiplayer.connect("peer_connected",_update_peer)
	_add_player(1)
	_hide_UI()
	$UI_related/UI/WaitingPlayer.show()
	
func _update_peer(_value:int)->void:
	is_two = true
	$UI_related/UI/bottom_box/action/Start.show()
	$UI_related/UI/WaitingPlayer.hide()
	
func _hide_UI()->void:
	internet_related.hide()
	
func _on_join_pressed()->void:
	SoundManager._play_sfx("Click")
	var to_connect:String = get_ip()
	if is_valid_ip(to_connect):
		_connect_procedure()
		
func _connect_procedure()->void:
	multiplayer.multiplayer_peer = peer
	multiplayer.connect("peer_disconnected",_disconnect)
	_add_player(2)
	_hide_UI()
	
func get_ip()->String:
	if GameSettings.is_lan_mode:
		return IP.get_local_addresses()[1]
	
	return $UI_related/ui/VBoxContainer/TextEdit.text
	
func is_valid_ip(ip:String)->bool:
	var result:Error = peer.create_client(ip,PORT)
	if result != OK:
		return false 
	print("connected to: ", ip)
	return true
	
func _add_player(id:int)->void:
	var player = playerscene.instantiate()
	player.name = str(id)
	player.set_multiplayer_authority(id)
	call_deferred("add_child",player)
	m_player = player
	
	#check if mouse clicked somewhere good
	m_player.connect("mouv_input",piece_manager._check_mouse_pos)
	
	
	#switch mouse to card mode
	card_manager.connect("CardQeued",m_player._switch_to_card_mode)
	m_player.connect("GetPos",piece_manager._verify_card_pos)
	piece_manager.connect("PosVerified",card_manager._send_card)
	#failure
	piece_manager.connect("StopQueuing",m_player._reset_card_mode)
	
	#show card ui
	$UI_related/UI/bottom_box.show()
	
func _reset_global()->void:
	# hide player color
	$UI_related/UI/bottom_box/Play/BlackKing.hide()
	$UI_related/UI/bottom_box/Play/WhiteKing.hide()
	#hide waiting player
	$UI_related/UI/WaitingPlayer.hide()
	#hide turn option
	$UI_related/UI/bottom_box/action/Start.hide()
	#hide defeat or victory
	$UI_related/Defeat.hide()
	$UI_related/Victory.hide()
	#reset
	m_player._reset()
	EventListenner._reset_action()
	EventListenner._reset_consequence()
	piece_manager._reset()
	card_manager._reset()
	_reset_board()
	turn = 0
	
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
		if is_starting == true:
			turn = 1
		_change_color(is_black)
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		rpc("_start_game", not is_starting, not is_black)

func is_peer_connected()->bool:
	return get_multiplayer().peer.is_active()

func _change_color(is_black:bool)->void:
	if is_black:
		$UI_related/UI/bottom_box/Play/BlackKing.show()
		$UI_related/UI/bottom_box/Play/WhiteKing.hide()
	else:
		$UI_related/UI/bottom_box/Play/BlackKing.hide()
		$UI_related/UI/bottom_box/Play/WhiteKing.show()

@rpc("call_remote","authority")
func _start_game(is_starting:bool,is_black:bool)->void:
	action_bar.visible = is_starting
	m_player.can_play = is_starting
	m_player.is_black = is_black
	_change_color(is_black)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if is_starting == true:
		turn = 1

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
		action._do_action(piece_manager)
	#prevent weird reset that doesn't make sens
	_start_turn()

func _start_turn()->void:
	EventListenner._reset_consequence()
	#allow player to do action
	action_bar.show()
	#can play
	m_player._do_next_turn()
	#remove possible action
	EventListenner._reset_action()
	#prevent action problem
	is_replaying = false
	if is_multiplayer_authority():
		print("Host can play")
	else:
		print("Client can play")
	turn += 1
	emit_signal("NewTurn")

func _do_consequence()->void:
	SoundManager._play_sfx("Reset")
	piece_manager._remove_shader()
	if EventListenner.did_action():
		m_player.can_play = true
		EventListenner._reset_action()
		card_manager._update_card()
		for consequence:Consequence in EventListenner.consequences:
			if consequence is MouvConsequence:
				print("trying to reverse mouvement consequence")
				consequence._reverse(piece_manager)
			if consequence is PieceTakenConsequence:
				print("trying to reverse piece taken")
				consequence._reverse(piece_manager)
			if consequence is CardConsequence:
				print("trying to reverse card consequence")
				consequence._reverse(self)
				
		EventListenner._reset_consequence()
	
func _send_action()->void:
	SoundManager._play_sfx("Click")
	if EventListenner.did_action():
		var action_to_send:Action = EventListenner.get_action()
		var to_add:String = "_host"
		#make sure we ask to update the right pc
		if is_multiplayer_authority():
			to_add = "_client"
		
		#send info as requiered
		if action_to_send is MouvAction:
			_send_movement_action(to_add,action_to_send)
			
		if action_to_send is CardAction:
			_send_card_action(to_add,action_to_send)
			
		EventListenner.action = null
			
		#prevent playing twice
		m_player.can_play = false
		m_player.is_lock_on_piece = false
		action_bar.hide()
		card_manager.progress_bar.hide()
		emit_signal("EndTurn")
		
func _send_movement_action(to_add:String,action_to_send:MouvAction)->void:
	var to_call:String = "_do_mouv_action"+to_add
	print("action was sent from :",is_multiplayer_authority()," to: ",not is_multiplayer_authority())
	rpc(
		to_call, #mouv function
		action_to_send.index, #who to move
		action_to_send.new_pos.x, #where on x
		action_to_send.new_pos.y) #where on y

func _send_card_action(to_add:String,action_to_send:CardAction)->void:
	var to_call:String = "_do_card_action"+to_add
	rpc(to_call,action_to_send.card_index,
	action_to_send.pos.x,
	action_to_send.pos.y,
	action_to_send.is_black)
	
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

@rpc("authority","call_remote")
func _do_card_action_client(index_of_the_card:int,pos_x:int,pos_y:int,is_black:bool)->void:
	_execute_card(index_of_the_card,pos_x,pos_y,is_black)
	
@rpc("any_peer","call_local")
func _do_card_action_host(index_of_the_card:int,pos_x:int,pos_y:int,is_black:bool)->void:
	if is_multiplayer_authority():
		_execute_card(index_of_the_card,pos_x,pos_y,is_black)

func _execute_card(index_of_the_card:int,pos_x:int,pos_y:int,is_black:bool)->void:
	is_replaying = true
	var card_to_use:CardStrategyPattern = CardLib.array_of_card[index_of_the_card]
	_spawn_card_use_anim(Vector2i(pos_x,pos_y))
	card_to_use._apply(pos_x,pos_y,is_black,self)
	_start_turn()

func _disconnect(id:int)->void:
	SoundManager._play_sfx("Error")
	print(id," is disconnected")
	_reset_global()
	remove_child(m_player)
	action_bar.hide()
	internet_related.show()
	$UI_related/UI/bottom_box/Play/BlackKing.hide()
	$UI_related/UI/bottom_box/Play/WhiteKing.hide()
	
func _reset_board()->void:
	var tilemap:TileMapLayer = piece_manager.tilemap
	for y:int in range(-10,6):
		for x:int in range(-18,18):
			if tilemap.get_cell_atlas_coords(Vector2i(x,y)) == Vector2i(-1,-1):
				var new_pos:Vector2i = Vector2i(x,y)
				var posi:Vector2i
				if new_pos.y%2 == 0:
					if new_pos.x%2 == 0:
						posi = Vector2i(1,0)
					else:
						posi = Vector2i(0,0)
				else:
					if new_pos.x%2 == 0:
						posi = Vector2i(0,0)
					else:
						posi = Vector2i(1,0)
			
				tilemap.set_cell(new_pos,0,posi)

func get_randint(lower_bound:int,upper_bound:int)->int:
	var trans_turn:int = (turn%piece_manager.get_child_count())
	var new_pos:Vector2i = piece_manager.array_pos[trans_turn]
	var c_seed:int = abs(new_pos.x * 2 - new_pos.y*9) * abs(new_pos.x * 4 - new_pos.y) + turn + EventListenner.sub_turn_tick
	EventListenner.sub_turn_tick += 1
	return get_randint_seed(c_seed,lower_bound,upper_bound)

func get_randint_seed(c_seed:int,lower_bound:int,upper_bound:int)->int:
	var random:RandomNumberGenerator = RandomNumberGenerator.new()
	random.seed = c_seed
	return random.randi_range(lower_bound,upper_bound)

func _spawn_card_use_anim(pos:Vector2i)->void:
	particle.global_position = piece_manager.get_map_pos(pos)
	particle.emitting = true
	
