shader_type canvas_item;

uniform float circle_size : hint_range(0.0, 1.05) = 0.5f;
uniform float screen_width;
uniform float screen_height;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float ratio = screen_width / screen_height;
	float dist = distance(vec2(0.5,0.5), vec2(mix(0.5, UV.x,ratio), UV.y));
	COLOR.a = step(circle_size,dist);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
