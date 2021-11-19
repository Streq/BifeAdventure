shader_type canvas_item;
uniform sampler2D input_palette;
uniform sampler2D output_palette;
uniform ivec2 size;

float find_color_in_base_palette(in vec4 color, float pal_size, float pixel_size) {
    for(float x = 0.0; x <= pal_size; x += pixel_size)   {      
        vec4 pal_col = texture(input_palette, vec2(x, 0.0));

        if(pal_col.rgba == color.rgba) {
            return x;
        }
    }

    return -1.0;
}

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    float pos = find_color_in_base_palette(color, float(size.x), TEXTURE_PIXEL_SIZE.x); 

    // We found the position of the color in the base palette, so fetch a new color from the new palette
    if(pos != -1.0) {
        COLOR = texture(output_palette, vec2(pos, 0.0));
    }
    // The color is not in the base palette, so we don't know its position. Keep the base color.
    else {
        COLOR = color;
    }   
}