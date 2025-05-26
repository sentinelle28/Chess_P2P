extends HBoxContainer
class_name CardManager

@export var current_card:Array[CardStrategyPattern] = []
@export var current_energy:int = 0

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
	pass
	
func _use_card(index:int)->void:
	pass


func can_use(card:CardStrategyPattern)->bool:
	if current_energy >= card.cost:
		_spend_energy(card.cost)
		return true
	return false 

func _spend_energy(energy_to_spend:int)->void:
	current_energy -= energy_to_spend
