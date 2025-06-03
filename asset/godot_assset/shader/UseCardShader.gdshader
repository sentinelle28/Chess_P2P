shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX.x += sin(TIME*2.)*3.;
	VERTEX.y += cos(TIME*2.)*3.;
}
