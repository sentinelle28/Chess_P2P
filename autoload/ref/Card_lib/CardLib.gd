extends Node

var array_of_card:Array[CardStrategyPattern] = [
	AddKnightMovement.new(),
	AddRookCard.new(),
	AddBeashopCard.new(),
	AddKingCard.new()
]

var array_of_rarity:Array[int] = [
	6,
	5,
	5,
	6
]

var total:int = 0

func _ready() -> void:
	for i:int in range(len(array_of_card)):
		array_of_card[i].index = i
		array_of_rarity[i] += total
		total += array_of_rarity[i]
		
func get_random_card()->CardStrategyPattern:
	var random_card:CardStrategyPattern
	var num:int = randi_range(0,total)
	var index:int = 0
	for i:int in range(len(array_of_rarity)):
		if num <= array_of_rarity[i]:
			index = i
			break
	random_card = array_of_card[index]
	return random_card
