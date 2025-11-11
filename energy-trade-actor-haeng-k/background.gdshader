shader_type canvas_item;

uniform vec4 top_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 bottom_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
    float t = UV.y; // 위→아래
    COLOR = mix(top_color, bottom_color, t);
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
