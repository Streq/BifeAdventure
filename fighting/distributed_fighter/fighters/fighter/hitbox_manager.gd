extends Node2D

func deactivate_all():
	for child in get_children():
		child.active = false
