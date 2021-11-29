extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var spawn = null
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn = $spawn
	remove_child(spawn)
	add_child(spawn.duplicate())

func _physics_process(delta):
	if $spawn.get_child_count()==0:
		remove_child($spawn)
		add_child(spawn.duplicate())
