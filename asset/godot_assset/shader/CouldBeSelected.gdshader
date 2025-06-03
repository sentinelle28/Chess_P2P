shader_type canvas_item;



void fragment() {
	COLOR.r = 1.;
	COLOR.g = 1.;
	COLOR.b = (sin(TIME*3.) + 1.)*0.2;
}

