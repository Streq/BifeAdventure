extends Node


func _ready():
	if !Globals.is_debug_build():
		get_parent().queue_free()
