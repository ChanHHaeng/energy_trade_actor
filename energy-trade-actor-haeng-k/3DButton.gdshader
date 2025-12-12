shader_type canvas_item;

uniform vec4 top_highlight : source_color = vec4(1.0, 1.0, 1.0, 0.12);
uniform vec4 bottom_shadow : source_color = vec4(0.0, 0.0, 0.0, 0.18);

uniform float edge_px = 8.0;  // 위/아래에 8px씩 그라데이션


void fragment() {
    vec4 base = COLOR;
    vec4 final_color = base;

    float px_height = 1.0 / SCREEN_PIXEL_SIZE.y;  // 텍스처 높이를 픽셀 기준으로 변환
    float y_px = UV.y * px_height;

    // 위쪽 하이라이트 0~edge_px 픽셀 사이 세로 그라데이션
    if (y_px < edge_px) {
        float t = smoothstep(0.0, edge_px, y_px);
        final_color += mix(top_highlight, vec4(0.0), t);
    }

    // 아래쪽 그림자 px-height-area
    if (y_px > px_height - edge_px) {
        float t = smoothstep(px_height - edge_px, px_height, y_px);
        final_color += mix(bottom_shadow, vec4(0.0), 1.0 - t);
    }

    COLOR = final_color;
}
