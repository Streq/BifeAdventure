extends TextureRect
tool
export var palette_path : NodePath setget set_palette_path
var ready = false

func set_palette_path(val:NodePath):
	palette_path = val
	if ready and val:
		var tex : ImageTexture = texture
		tex.create_from_image(get_node(val).texture.get_)
		
func _ready():
	ready = true
	set_palette_path(palette_path)
