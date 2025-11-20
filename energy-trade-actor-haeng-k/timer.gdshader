shader_type canvas_item;

uniform float length : hint_range(50, 1000) = 200.0;
uniform float thickness : hint_range(5, 200) = 40.0;
uniform float aa : hint_range(0.5, 3.0) = 1.5;
uniform vec4 Color: source_color;

void fragment() {
    // 좌표 (-1~1)
    vec2 uv = (UV * 2.0 - 1.0);

    // x 중심에서 얼마나 떨어져있는지
    float t = (uv.x + 1.0) * 0.5;  // 0~1

    // 유선형 두께 함수
    float half_w = (thickness * 0.5) * sin(3.141592 * t);

    // 현재 y좌표가 유선형 안인지
    float d = abs(uv.y) * (length / 2.0) - half_w;

    // anti-aliased edge
    float alpha = smoothstep(aa, -aa, -d);

    COLOR = Color- vec4(0, 0, 0, alpha);
}
