shader_type canvas_item;

uniform vec3 base_color : source_color = vec3(0.85, 0.85, 0.88); // 은색
uniform float highlight_strength : hint_range(0.0, 1.0) = 0.5; // 반사광 세기
uniform vec2 resolution = vec2(400.0, 200.0); // 패널 크기

void fragment() {
    vec2 uv = FRAGCOORD.xy / resolution;

    // 둥근 반사광: 상단 중심에서 퍼지는 하이라이트
    float highlight = smoothstep(0.0, 0.5, 1.0 - length(uv - vec2(0.5, 0.3))) * highlight_strength;

    // 세로 Gradient: 상단 밝게 → 하단 약간 어둡게
    float vertical_grad = mix(0.05, -0.05, uv.y);

    vec3 color = base_color + highlight + vertical_grad;

    COLOR = vec4(color, 1.0);
}
