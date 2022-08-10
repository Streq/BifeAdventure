extends Node
tool
onready var palette = $palette


func _ready():
	yield(owner,"ready")
	var mat :ShaderMaterial = owner.material
	mat.set_shader_param("palette", palette.texture)
