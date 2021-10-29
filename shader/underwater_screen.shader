shader_type canvas_item;
uniform float blue = 1.0; // you can assign a default value to uniforms

void fragment(){
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV+vec2(cos(SCREEN_UV.y*2.0+TIME*1.0)*0.01,0)); //read from texture
	COLOR.b = blue;
}
