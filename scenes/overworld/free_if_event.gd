extends Node

export(Globals.EVENTS) var event = Globals.EVENTS.tutorial_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	if !Globals.things_that_happened.has(event):
		set_physics_process(false)

func _physics_process(delta):
	get_parent().queue_free()
