shader_type canvas_item;

void vertex() {
	VERTEX.y += sin(TIME*2.)*2. - 2.5;
}

