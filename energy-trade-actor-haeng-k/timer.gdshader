shader_type canvas_item;

uniform float length : hint_range(50.0, 1000.0) = 200.0;
uniform float thickness : hint_range(5.0, 200.0) = 40.0;
uniform float aa : hint_range(0.5, 3.0) = 1.5;

uniform vec4 fill_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);  // 유선형 내부 색
uniform vec4 line_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);  // 테두리 색
uniform float line_width : hint_range(0.0, 20.0) = 2.0;              // 테두리 두께

void fragment() {
    // UV 좌표 (-1 ~ 1)
    vec2 uv = UV * 2.0 - 1.0;

    // x축 진행률
    float t = (uv.x + 1.0) * 0.5;

    // 유선형 반두께
    float half_w = (thickness * 0.5) * sin(3.141592 * t);

    // 거리값 (유선형 중앙선 기준)
    float d = abs(uv.y) * (length / 2.0) - half_w;

    // 내부 alpha (유선형 영역)
    float fill_alpha = smoothstep(aa, -aa, -d);

    // 테두리 alpha (유선형 외곽선)
    float border_alpha = smoothstep(line_width + aa, line_width - aa, abs(d));

    // 내부 색과 테두리 색 혼합
    vec4 color = mix(fill_color, line_color, border_alpha);

    // 내부 영역만 나타나도록 alpha 적용
    COLOR = COLOR-vec4(color.rgb, color.a * fill_alpha);
}
