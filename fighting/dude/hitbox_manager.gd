extends Node2D

signal clear()

func _ready():
	for child in get_children():
		child.deactivate()
		connect("clear", child, "deactivate")

func activate_hitbox(id):
	var hitbox = get_node(id)
	hitbox.activate()

func deactivate_hitbox(id):
	var hitbox = get_node(id)
	hitbox.deactivate()


func clear():
	emit_signal("clear")
