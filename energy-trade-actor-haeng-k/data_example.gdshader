shader_type canvas_item;

uniform bool flip_h = false;
uniform bool flip_v = false;

void fragment() {
	vec2 uv = vec2(
		flip_h ? 1.0 - UV.x : UV.x,
		flip_v ? 1.0 - UV.y : UV.y);
	COLOR = texture(TEXTURE, uv);
}