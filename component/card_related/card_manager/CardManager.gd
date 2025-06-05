extends HBoxContainer
class_name CardManager

signal CardQeued #notify mouse that it needs to check pos

@export var current_card:Array[CardStrategyPattern] = []
@export var current_energy:int = 0
@export var progress_bar:ProgressBar

var has_resized:bool = false
var current_queued_card:CardStrategyPattern

func _ready() -> void:
	for card:CardHolder in get_children():
		card.connect("discard",_discard_card)
		card.connect("use",_use_card)
		
	EventListenner.connect("DidAction",_prevent_card)
	
func _prevent_card()->void:
	for i:int in range(3):
		get_child(i).hide()

func _update_card()->void:
	progress_bar.show()
	for i:int in range(3):
		if len(current_card) >= i+1:
			_show_card_rarity(i)
			_update_display(i)
			_show_use_button(i)
		else:
			get_child(i).hide()
	progress_bar.value = current_energy
	
func _show_card_rarity(index:int)->void:
	var card_holder:CardHolder = get_child(index)
	card_holder.show()
	
	
	
func _show_use_button(index:int)->void:
	if current_card[index].get_cost() <= current_energy:
		var child:CardHolder = get_child(index)
		var button:Button = child.get_node("VBoxContainer/Action_Bar/Use")
		button.show()
		button.text = "Use (" + str(current_card[index].get_cost()) + ")"
	
		
func _update_display(index:int)->void:
	var card:CardHolder = get_child(index)
	card._change_card(current_card[index])
	
	
func _discard_card(index:int)->void:
	SoundManager._play_sfx("Click")
	current_card.remove_at(index)
	current_energy += 1
	_update_card()
	
	
func _use_card(index:int)->void:
	SoundManager._play_sfx("Click")
	current_queued_card = current_card[index]
	if current_queued_card is AddMovementCard:
		get_tree().current_scene.piece_manager._add_shader_to_piece(ThemeRef.could_be_selected_shader)
	
	emit_signal("CardQeued")
	

func _send_card(pos:Vector2i,is_black:bool)->void:
	_spend_energy(current_queued_card.get_cost())
	var gameplay:GameplayScene = get_tree().current_scene
	var true_pos:Vector2 = gameplay.piece_manager.get_map_pos(pos)
	var size_of_card:Vector2 = get_child(0).size
	gameplay.card_anim._do_animation(true_pos,current_queued_card,size_of_card)
	#temp destroy thingy
	var temp:CardStrategyPattern = current_queued_card
	current_card.erase(current_queued_card)
	current_queued_card = null
	EventListenner.emit_signal("UseCard",temp.index,pos,is_black)
	


func _spend_energy(energy_to_spend:int)->void:
	current_energy -= energy_to_spend
	print("spent ", energy_to_spend," to use card")

func _reset()->void:
	has_resized = false
	current_card.clear()
	current_energy = 0
	for i:int in range(3):
		get_child(i).hide()
		
func _update_energy()->void:
	show()
	current_energy += 1
	#add card to hand
	_add_card_to_hand()
	_update_card()
	
func _add_card_to_hand()->void:
	if len(current_card) < 3:
		current_card.append(CardLib.get_random_card())
		
