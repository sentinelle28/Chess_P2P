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
	DiguiseCard.new(),
	DuplicateCard.new(),
	AddRandomMove.new(),
	AddKnightExtanded.new(),
	HideCard.new(),
	PaintCard.new(),
	LostControlCard.new(),
	WoodCard.new(),
	HazardousBulletCard.new(),
	WindDownCard.new(),
	WindUpCard.new(),
	WindLeftCard.new(),
	WindRightCard.new(),
	CursedCard.new(),
	LightningCard.new(),
	CharmedCard.new(),
	BanCard.new(),
	BetrayalCard.new(),
	BridgeCard.new(),
	ConfusionCard.new()
]

var array_of_rarity:Array[int] = []

var total:int = 0

func _ready() -> void:
	for i:int in range(len(array_of_card)):
		array_of_card[i].index = i
		array_of_rarity.append(6 - array_of_card[i].get_rarity())
		#if i == len(array_of_card) - 1:
		#	array_of_rarity[i] = 10000
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
