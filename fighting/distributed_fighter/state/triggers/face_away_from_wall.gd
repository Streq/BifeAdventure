extends Node


func trigger():
	var root = get_parent().root
	if root.is_against_wall(1):
		root.facing_right = !root.facing_right
