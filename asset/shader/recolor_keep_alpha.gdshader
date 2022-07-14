shader_type canvas_item;
uniform float red = 1.0; // you can assign a default value to uniforms
uniform vec4 color : hint_color;

void fragment(){
	COLOR = texture(TEXTURE, UV); //read from texture
	vec2 pixel = UV / TEXTURE_PIXEL_SIZE;
	COLOR.rgb = color.rgb;
}