extends Area2D

export(Globals.EVENTS) var event = Globals.EVENTS.tutorial_completed


func _ready():
	set_process_input(false)

func _on_door_body_entered(body):
	if body.is_in_group("player"):
		set_process_input(true)

func _on_door_body_exited(body):
	if body.is_in_group("player"):
		set_process_input(false)

func _input(e):
	if e.is_action_pressed("A0"):
		Globals.things_that_happened[event] = true
