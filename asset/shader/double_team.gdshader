shader_type canvas_item;

uniform float time = 0.0;

void fragment(){
	float horizontal_offset = 0.0;
	COLOR.a = 0.0;
	if(mod(UV.y, TEXTURE_PIXEL_SIZE.y*2.0) < TEXTURE_PIXEL_SIZE.y){
		if(mod(time*60.0,8.0)>=4.0){
			COLOR.a = 0.0;
			return;
		}
		horizontal_offset = TEXTURE_PIXEL_SIZE.y*time*10.0;
	}
	else {
		if(mod(time*60.0,8.0)<4.0){
			COLOR.a = 0.0;
			return;
		}
		horizontal_offset = -TEXTURE_PIXEL_SIZE.y*time*10.0;
	}
	COLOR = texture(TEXTURE, UV + vec2(horizontal_offset, 0.0)); //read from texture
	
	
}
