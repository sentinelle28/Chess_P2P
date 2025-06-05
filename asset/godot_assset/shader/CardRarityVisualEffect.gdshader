shader_type canvas_item;




// Called for every pixel the material is visible on.
void fragment() {
	float speed = 1.1;
	float range = 0.1;
	float reajuster = 1. - range;
	// goes from 0.8 to 1.0
	float normal_sin = (sin(TIME*speed)+1.)*range + reajuster;
	COLOR *= normal_sin;
}

