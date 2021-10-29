shader_type canvas_item;
uniform float blue = 1.0; // you can assign a default value to uniforms

void fragment(){
	COLOR = texture(TEXTURE, UV+vec2(cos(UV.y*2000.0+TIME*20.0)*0.01,0)); //read from texture
	COLOR.b = blue;
}
