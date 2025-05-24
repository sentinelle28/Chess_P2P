extends Node
const beginning_pos:Array[Vector2i] = [
	Vector2i(-1,3),#black king
	Vector2i(0,3),#black queen
	Vector2i(-2,3),#black beashop left
	Vector2i(1,3),#black beashop right
	Vector2i(-3,3), #black knight left
	Vector2i(2,3), #black knight right
	Vector2i(-4,3),#black rook left
	Vector2i(3,3), #black rook right
	
	Vector2i(-4,2), #first black pawn
	Vector2i(-3,2), #second black pawn
	Vector2i(-2,2), #third black pawn
	Vector2i(-1,2), #fourth black pawn
	Vector2i(0,2), #fith black pawn
	Vector2i(1,2), #six black pawn
	Vector2i(2,2), #seventh black pawn
	Vector2i(3,2), #heigth black pawn
	
	
	Vector2i(0,-4),#white king
	Vector2i(-1,-4),#white queen
	Vector2i(-2,-4),#white beashop left
	Vector2i(1,-4),#white beashop right
	Vector2i(-3,-4), #white knight left
	Vector2i(2,-4), #white knight right
	Vector2i(-4,-4),#white rook left
	Vector2i(3,-4), #white rook right
	
	Vector2i(-4,-3), #first white pawn
	Vector2i(-3,-3), #second white pawn
	Vector2i(-2,-3), #third white pawn
	Vector2i(-1,-3), #fourth white pawn
	Vector2i(0,-3), #fith white pawn
	Vector2i(1,-3), #six white pawn
	Vector2i(2,-3), #seventh white pawn
	Vector2i(3,-3), #heigth white pawn
]
