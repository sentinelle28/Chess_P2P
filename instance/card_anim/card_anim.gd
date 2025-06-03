extends Panel
class_name CardAnim

@onready var name_label:Label = $VBoxContainer/Name_Label
@onready var description_label:Label = $VBoxContainer/DescriptionLabel
@onready var anim:AnimationPlayer = $AnimationPlayer

func _do_animation(pos:Vector2,card:CardStrategyPattern,card_size:Vector2)->void:
	var tween:Tween = get_tree().create_tween()
	var posi:Vector2 = pos - 0.5 * card_size
	size = card_size
	global_position = Vector2(552.0,576.0) - 0.5*card_size
	name_label.text = card.get_card_name()
	description_label.text = card.get_description()
	show()
	tween.tween_property(self,"global_position",posi,0.5)
	anim.play("UseCard")
