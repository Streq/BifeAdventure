extends "res://util/state/state.gd"

var jumps = 0
var max_jumps = 3
var timeout = false

func enter():
	timeout = false
	jumps = 0
	
func handle(character, controller):
	if controller.target:
		var dist : Vector2= controller._target_distance()
		if character.is_on_floor():
			controller.direction.x = sign(dist.x)
		else:
			controller.direction.x = -sign(dist.x)
		if !character.state.current_state.stunned:
			if !timeout: 
				if $Timer.is_stopped():
					$Timer.start()
			else:
				if jumps != max_jumps:
					if character.is_on_floor():
						jumps += 1
						controller.buttonA.pressed(true)
				elif character.is_on_floor():
						controller.buttonC.pressed(true)
						emit_signal("finished","follow", null)
			




func _on_Timer_timeout():
	timeout = true
