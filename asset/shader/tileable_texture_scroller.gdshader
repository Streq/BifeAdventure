shader_type canvas_item;
uniform vec2 scroll_vec = vec2(1.0,1.0);

void fragment(){
	COLOR = texture(TEXTURE, UV+vec2(TIME,TIME)*scroll_vec); //read from texture
}
