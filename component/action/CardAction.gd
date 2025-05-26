extends Action
class_name CardAction
var card_index:int
var pos:Vector2i
var is_black:bool

func _do_action(node:Node)->void:
	CardLib.array_of_card[card_index]._apply(pos.x,pos.y,is_black)
	
