shader_type canvas_item;



void fragment() {
	COLOR.r = 1. + (sin(TIME*3.) * 0.15);
	COLOR.g = 1. + (sin(TIME*3.) * 0.15);
}

