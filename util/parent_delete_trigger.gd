extends Node


func trigger():
	get_parent().queue_free()
