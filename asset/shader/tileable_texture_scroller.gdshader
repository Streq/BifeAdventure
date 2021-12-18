shader_type canvas_item;
uniform vec2 scroll_vec = vec2(1.0,1.0);

void fragment(){
	vec2 offset = mod(UV + vec2(TIME, TIME)*scroll_vec, vec2(1.0,1.0));
	
	COLOR = texture(TEXTURE, offset); //read from texture
}
