extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var spawn = null
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn = $spawn
	_spawn()
	
func _physics_process(delta):
	if $spawn.get_child_count()==0:
		_spawn()

func _spawn():
	remove_child($spawn)
	add_child(spawn.duplicate())
