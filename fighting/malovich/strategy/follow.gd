extends "res://util/state/state.gd"

var timeout := false

func enter():
	$Timer.start()
	timeout = false
	
func handle(character, controller):
	if is_instance_valid(controller.target):
		var dist : Vector2= controller._target_distance()
		controller.direction.x = sign(dist.x)
		if(timeout or character.state.current=="hurt"):
			var length_squared : float = dist.length_squared()
			if(length_squared < 48*48):
				emit_signal("finished", "punch", null)


func _on_Timer_timeout():
	timeout = true
