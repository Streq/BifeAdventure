shader_type canvas_item;

uniform float outline_width = 1.0;
uniform vec4 outline_color: hint_color;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	vec2 ps = TEXTURE_PIXEL_SIZE;
	float a;
	//start with current pixel alpha
	float maxa = col.a;
	float mina = col.a;
	
	
	//get alpha of the neighboring pixels
	a = texture(TEXTURE, UV + vec2(0.0, -outline_width) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(0.0, outline_width) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(-outline_width, 0.0) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(outline_width, 0.0) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);
	
	//we end up with the lowest and highest alphas of the 5 pixel cross
	//mix the color with the outline color, the more contrast between alphas
	//the more we'll outline
	COLOR = mix(col, outline_color, maxa - col.a);
	//COLOR.a = 0.0;
}
