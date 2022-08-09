extends TextureRect


func _ready():
	var aux_flags = texture.flags
	texture.flags = aux_flags+1
	yield(get_tree(),"idle_frame")
	texture.flags = aux_flags
	
