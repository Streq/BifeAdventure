extends Node


func _ready():
	if !OS.is_debug_build():
		get_parent().queue_free()
