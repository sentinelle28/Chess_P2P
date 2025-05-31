shader_type canvas_item;

void vertex() {
	VERTEX.y = VERTEX.y + sin(TIME*1.5)*2.;
}

