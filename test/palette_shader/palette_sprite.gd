extends Sprite
tool
export var palette : Texture setget set_palette

#TODO CREATE TEXTURE WITH ALL PALETTES AND SHIFT LOGIC

func set_palette(val):
	palette = val
	var shader : ShaderMaterial = material
	shader.set_shader_param("palette", palette) 
