shader_type canvas_item;
uniform vec4 color : hint_color;

void fragment(){
	COLOR = texture(TEXTURE, UV); //read from texture
	vec2 pixel = UV / TEXTURE_PIXEL_SIZE;
	if (mod(pixel.x + pixel.y, 2.0)<1.0){
		COLOR = vec4(color.rgb, COLOR.a);
	}
	
}
