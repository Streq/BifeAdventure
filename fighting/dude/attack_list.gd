extends Node


func _physics_process(delta):
	for child in get_children():
		if child.check_satisfy():
			child.enter()
			break
