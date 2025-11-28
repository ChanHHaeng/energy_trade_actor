shader_type canvas_item;

uniform vec4 top_color : source_color;
uniform vec4 bottom_color : source_color;

// 0.0~1.0 : 그라데이션이 끝나는 지점을 조절
uniform float gradient_end : hint_range(0.0, 1.0) = 1.0;

uniform float border_width : hint_range(0.0, 20.0) = 0.0;
uniform vec4 border_color : source_color;

uniform vec2 rect_size; // 패널 크기

void fragment() {
    vec2 pixel = UV * rect_size;

    // ★ 그라데이션 진행 조절
    float t = UV.x / gradient_end;
    t = clamp(t, 0.0, 1.0);

    vec4 base = mix(top_color, bottom_color, t);

    bool is_border =
        pixel.x <= border_width ||
        pixel.x >= rect_size.x - border_width ||
        pixel.y <= border_width ||
        pixel.y >= rect_size.y - border_width;

    COLOR = is_border ? border_color : base;
}