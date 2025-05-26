extends Node

var array_of_card:Array[CardStrategyPattern] = [
	AddKnightMovement.new(),
	AddRookCard.new(),
	AddBeashopCard.new(),
	AddKingCard.new()
]

func _ready() -> void:
	for i:int in range(len(array_of_card)):
		array_of_card[i].index = i
