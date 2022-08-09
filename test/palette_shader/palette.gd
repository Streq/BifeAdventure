extends Node2D
tool

export (PoolColorArray) var main_colors : PoolColorArray setget set_main_colors
export (Array, PoolColorArray) var main_colors2 setget set_main_colors2

export var update_from_import : bool setget update_from_import
export var import : Texture setget import
export var columns := 4 setget set_columns
onready var texture_rect = $TextureRect

var ready = false
var texture : Texture setget, get_texture

func get_texture():
	return texture_rect.texture

func import(val:Texture):
	import = val

func update_from_import(val):
	var img = import.get_data()
	if img:
		img.lock()
		columns = img.get_width()
		var colors = []
		for j in img.get_height():
			for i in img.get_width():
				colors.append(img.get_pixel(i,j))
		img.unlock()
		set_main_colors(PoolColorArray(colors))
		property_list_changed_notify()

func set_main_colors(val):
	main_colors = val
	if ready:
		update_texture()

func set_main_colors2(val):
	main_colors2 = val
	
	var max_columns = 0
	for row in main_colors2:
		max_columns = max(row.size(), max_columns)
	columns = max_columns
	
	var rows = main_colors2.size()
	
#	main_colors.resize(columns*rows)
#
	
#	for j in main_colors2.size():
#		var row = main_colors2[j]
#		var row_size = row.size()
#		for i in columns:
#			var color
#			if i < row_size:
#				color = row[i]
#			else:
#				color = Color.black
#			main_colors[j*columns+i] = color

	if ready:
		update_texture()

func set_columns(val):
	columns = val
	if ready:
		update_texture()
		
func update_texture():
	var img_tex : ImageTexture = texture_rect.texture
	var aux_flags = img_tex.flags
	if main_colors.size()>0:
		var img = Image.new()
		var size = main_colors.size()
		img.create(columns, size/columns+int(bool(size%columns)),false,Image.FORMAT_RGBA8)
		img.lock()
		for i in main_colors.size():
			img.set_pixel(i%columns, i/columns, main_colors[i])
		img.unlock()
		img_tex.create_from_image(img)
	else:
		img_tex.create(1,1,0)
	img_tex.flags = aux_flags


func _ready():
	ready = true
	texture_rect.texture = texture_rect.texture.duplicate() 
	set_main_colors(main_colors)
	
