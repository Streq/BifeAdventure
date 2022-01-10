extends Node

export(Globals.EVENT) var event = Globals.EVENT.tutorial_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	if !Globals.get_event(event):
		set_physics_process(false)

func _physics_process(delta):
	get_parent().queue_free()
