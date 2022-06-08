extends Node2D

signal all_dead()

func _ready():
	for child in get_children():
		child.connect("tree_exited", self, "_on_child_exited")

func _on_child_exited():
	if get_child_count() == 0:
		emit_signal("all_dead")
