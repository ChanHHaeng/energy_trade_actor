shader_type canvas_item;

uniform vec4 glass_color : source_color = vec4(0.9, 0.95, 1.0, 0.25); // 기본 유리색
uniform float highlight_strength : hint_range(0.0, 2.0) = 1.0;
uniform float shadow_strength : hint_range(0.0, 2.0) = 0.6;

void fragment() {
    vec2 uv = UV;

    // 기본 유리 색
    vec4 col = glass_color;

    // 위쪽 하이라이트 (곡선)
    float highlight = smoothstep(0.0, 0.4, 1.0 - uv.y);
    col.rgb += vec3(1.0) * highlight * 0.2 * highlight_strength;

    // 아래쪽 그림자
    float shadow = smoothstep(0.6, 1.0, uv.y);
    col.rgb -= vec3(0.15) * shadow * shadow_strength;

    // 내부 은은한 그라데이션
    col.rgb *= 0.95 + uv.y * 0.05;

    COLOR = col;
}