shader_type canvas_item;

uniform vec4 top_color : source_color;
uniform vec4 bottom_color : source_color;

uniform float border_width : hint_range(0.0, 20.0) = 0.0;
uniform vec4 border_color : source_color;

uniform vec2 rect_size; // 패널 실제 크기(px)

void fragment() {
    // UV(0~1)를 실제 픽셀 좌표로 변환
    vec2 pixel = UV * rect_size;

    // 그라데이션
    float t = UV.x;
    vec4 base = mix(top_color, bottom_color, t);

    // 테두리 체크 (절대 px 기준)
    bool is_border =
        pixel.x <= border_width ||
        pixel.x >= rect_size.x - border_width ||
        pixel.y <= border_width ||
        pixel.y >= rect_size.y - border_width;

    COLOR = is_border ? border_color : base;
}
