extends Panel
class_name CardHolder

signal discard(index:int)
signal use(index:int)

@onready var self_index:int = get_index()

@onready var name_label:Label = $VBoxContainer/Control/Name_of_the_card
@onready var description_label:Label = $VBoxContainer/Control2

func _ready() -> void:
	$VBoxContainer/Action_Bar/Discard.connect("pressed",_discard)
	$VBoxContainer/Action_Bar/Use.connect("pressed",_use)
	
	
func _discard()->void:
	emit_signal("discard",self_index)
	
func _use()->void:
	emit_signal("use",self_index)
	
func _change_card(card:CardStrategyPattern)->void:
	_change_descrition(card.get_description())
	_change_name(card.get_card_name())

func _change_descrition(new_desc:String)->void:
	description_label.text = new_desc

func _change_name(new_name:String)->void:
	name_label.text = new_name
