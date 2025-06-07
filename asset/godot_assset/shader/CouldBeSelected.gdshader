shader_type canvas_item;

void vertex() {
	VERTEX.y += sin(TIME*2.)*2. - 2.5;
}

void fragment() {
	float normal_sin = (sin(TIME*3.) + 1.)/2.;
	if (normal_sin > 0.5)
	{
		COLOR.r = 1.;
		COLOR.g = 1.;
	}
}

