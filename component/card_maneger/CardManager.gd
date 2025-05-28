extends HBoxContainer
class_name CardManager

signal CardQeued

@export var current_card:Array[CardStrategyPattern] = []
@export var current_energy:int = 0
@export var progress_bar:ProgressBar

var current_queued_card:CardStrategyPattern

func _ready() -> void:
	for card:CardHolder in get_children():
		card.connect("discard",_discard_card)
		card.connect("use",_use_card)

func _update_card()->void:
	for i:int in range(3):
		if len(current_card) >= i+1:
			get_child(i).show()
			_update_display(i)
			_show_use_button(i)
		else:
			get_child(i).hide()
	progress_bar.value = current_energy
	
func _show_use_button(index:int)->void:
	if current_card[index].get_cost() >= current_energy:
		var child:CardHolder = get_child(index)
		var button:Button = child.get_node("VBoxContainer/Action_Bar/Use")
		button.show()
		button.text = "Use (" + str(current_card[index].get_cost()) + ")"
		
func _update_display(index:int)->void:
	var card:CardHolder = get_child(index)
	card._change_card(current_card[index])
	
	
func _discard_card(index:int)->void:
	current_card.remove_at(index)
	current_energy += 1
	
	
func _use_card(index:int)->void:
	current_queued_card = current_card[index]
	emit_signal("CardQeued")
	

func _send_card(pos:Vector2i,is_black:bool)->void:
	_spend_energy(current_queued_card.get_cost())
	EventListenner.emit_signal("UseCard",current_queued_card.index,pos,is_black)
	current_card.erase(current_queued_card)
	current_queued_card = null
	_update_card()


func _spend_energy(energy_to_spend:int)->void:
	current_energy -= energy_to_spend

func _reset()->void:
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
		current_card.append(CardLib.array_of_card[0])
		
