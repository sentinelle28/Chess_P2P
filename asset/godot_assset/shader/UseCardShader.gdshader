shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
	if (VERTEX.y > 0.5)
	{
		VERTEX.x += sin(TIME)*5.;
	}
	else
	{
		VERTEX.x -= sin(TIME*2.)*2.;
	}
	
	if (VERTEX.x > 0.5)
	{
		VERTEX.y += cos(TIME*0.7)*3.;
	}
	else
	{
		VERTEX.y -= cos(TIME*2.)*6.;
	}
	
	
}
