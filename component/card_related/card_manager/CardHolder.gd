extends Panel
class_name CardHolder

signal discard(index:int)
signal use(index:int)

@onready var self_index:int = get_index()

@onready var name_label:Label = $VBoxContainer/Control/Name_of_the_card
@onready var description_label:Label = $VBoxContainer/Control2
@onready var discard_button:Button = $VBoxContainer/Action_Bar/Discard
@onready var use_button:Button = $VBoxContainer/Action_Bar/Use

func _ready() -> void:
	discard_button.connect("pressed",_discard)
	use_button.connect("pressed",_use)
	
	
func _discard()->void:
	emit_signal("discard",self_index)
	use_button.hide()
	
func _use()->void:
	emit_signal("use",self_index)
	use_button.hide()
	
func _change_card(card:CardStrategyPattern)->void:
	_change_descrition(card.get_description())
	_change_name(card.get_card_name())

func _change_descrition(new_desc:String)->void:
	description_label.text = new_desc

func _change_name(new_name:String)->void:
	name_label.text = new_name
