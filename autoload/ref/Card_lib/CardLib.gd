extends Node

var array_of_card:Array[CardStrategyPattern] = [
	AddKnightMovement.new(),
	AddRookCard.new(),
	AddBeashopCard.new(),
	AddKingCard.new(),
	SummonPawn.new(),
	SummonKnight.new(),
	SummonBeashop.new(),
	SummonRook.new(),
	SummonQueen.new(),
	DestroyOneCard.new(),
	DestroyThreeCard.new(),
	DestroynineCard.new(),
	BetrayalCard.new(),
	DiguiseCard.new(),
	DuplicateCard.new(),
	AddRandomMove.new(),
	AddKnightExtanded.new(),
	HideCard.new(),
	PaintCard.new(),
	LostControlCard.new()
]

var array_of_rarity:Array[int] = [
	5, #AddKnightMovement
	5, #AddRookCard
	5, #AddBeashopCard
	5, #AddKingCard
	5, #SummonPawn
	4, #SummonKnight
	3, #SummonBeashop
	3, #SummonRook
	2, #SummonQueen
	4, #destroy 1 tile
	3, #destroy 3 tile
	1, #destroy 9 tile
	3, #betrayal card
	3, #diguise card
	2,# duplicate card
	3, #add random move
	3, # add extanded knight
	1, #hide card
	1, #paint card
	1 #lost control card
]

var total:int = 0

func _ready() -> void:
	for i:int in range(len(array_of_card)):
		array_of_card[i].index = i
		total += array_of_rarity[i]
		array_of_rarity[i] = total
		
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
