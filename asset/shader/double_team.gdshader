shader_type canvas_item;

uniform float time = 0.0;

void fragment(){
	float horizontal_offset = 0.0;
	COLOR.a = 0.0;
	bool draw = false;
	if(mod(UV.y, TEXTURE_PIXEL_SIZE.y*2.0) < TEXTURE_PIXEL_SIZE.y){
		if(mod(time*60.0,8.0)>=4.0){
			COLOR.a = 0.0;
		}
		else{
			horizontal_offset = TEXTURE_PIXEL_SIZE.y*time*10.0;
			draw = true;
		}
	}
	else {
		if(mod(time*60.0,8.0)<4.0){
			COLOR.a = 0.0;
		}
		else{
			horizontal_offset = -TEXTURE_PIXEL_SIZE.y*time*10.0;
			draw = true;
		}
	}
	if(draw){
		COLOR = texture(TEXTURE, UV + vec2(horizontal_offset, 0.0)); //read from texture
	}
	
	
}
