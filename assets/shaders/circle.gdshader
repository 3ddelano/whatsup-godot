// https://godotshaders.com/snippet/circle/
shader_type canvas_item;

float circle(vec2 position, float radius, float feather) {
	return 1.0 - smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}

void fragment() {
	COLOR.a = circle(UV, 0.5, 0.005);
}
