shader_type canvas_item;

uniform float time;
uniform float white_increment = 0.1;
uniform float saturation_factor = 10.0;
void fragment(){
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV); //read from texture
	COLOR.rgb += time * white_increment;
	COLOR.rgb *= 1.0 + time * saturation_factor;
//	COLOR -= time;
//	COLOR = clamp(COLOR,0.0,1.0);
}
