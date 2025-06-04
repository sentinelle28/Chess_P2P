shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
	if (VERTEX.y > 0.5)
	{
		VERTEX.x -= sin(-TIME*10.)*8.;
	}
	else
	{
		VERTEX.x += sin(TIME*10.)*10.;
	}
	
	if (VERTEX.x > 0.5)
	{
		VERTEX.y += cos(-TIME*10.)*7.;
	}
	else
	{
		VERTEX.y -= cos(TIME*10.)*10.;
	}
	float temp = VERTEX.y * sin(TIME*3.) * 0.2;
	VERTEX.y += VERTEX.x*cos(TIME*3.)*0.3;
	VERTEX.x += temp;
	
}
