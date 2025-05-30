extends ComputeMouvOption
class_name PawnMouvOption

func get_compute_possible_mouv(tilemap:TileMapLayer,
pos:Vector2i,
array_of_piece:Array[Vector2i] )->Array[Vector2i]:
	var array:Array[Vector2i] = [
		Vector2i(1,0), # droite
		Vector2i(-1,0), #gauche
		Vector2i(0,1), #bas
		Vector2i(0,-1)] #haut
	var to_check:Array[Vector2i] = [
		Vector2i(1,1), # diag droite bas
		Vector2i(1,-1), #diag droite haut
		Vector2i(-1,-1), #diag gauche haut
		Vector2i(-1,1)] #diag gauche bas
	
	var temp_array:Array[Vector2i] = []
	for i:int in range(len(array)):
		#nand
		if (is_in_board(array[i]+pos,tilemap) and is_empity(array[i]+pos,array_of_piece)):
			temp_array.append(array[i])
			
		
		if is_in_board(to_check[i]+pos,tilemap) and (not is_empity(to_check[i]+pos,array_of_piece)):
			temp_array.append(to_check[i])
	
	return temp_array
