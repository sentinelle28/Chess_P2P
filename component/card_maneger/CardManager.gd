extends HBoxContainer
class_name CardManager

signal CardQeued

@export var current_card:Array[CardStrategyPattern] = []
@export var current_energy:int = 0

var current_queued_card:int = 4

func _ready() -> void:
	for card:CardHolder in get_children():
		card.connect("discard",_discard_card)
		card.connect("use",_use_card)

func _update_card()->void:
	for i:int in range(3):
		if len(current_card) >= i+1:
			get_child(i).show()
			_update_display(i)
		else:
			get_child(i).hide()
	
func _update_display(index:int)->void:
	var card:CardHolder = get_child(index)
	card._change_card(current_card[index])
	
	
func _discard_card(index:int)->void:
	current_card.remove_at(index)
	current_energy += 1
	
	
func _use_card(index:int)->void:
	current_queued_card = index
	emit_signal("CardQeued")
	

func _send_card(pos:Vector2i,is_black:bool)->void:
	var current_card_object:CardStrategyPattern = current_card[current_queued_card]
	EventListenner.emit_signal("UseCard",current_card_object.index,pos,is_black)

func can_use(card:CardStrategyPattern)->bool:
	var cost:int = card.get_cost()
	if current_energy >= cost:
		_spend_energy(cost)
		return true
	return false 

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
