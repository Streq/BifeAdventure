shader_type canvas_item;
uniform float blue = 1.0; // you can assign a default value to uniforms

void fragment(){
	float mo = (cos(SCREEN_UV.y*2.0+TIME*1.0)*0.01);
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV+vec2(mo - mod(mo,SCREEN_PIXEL_SIZE.x),0)); //read from texture
	COLOR.b = blue;
}
