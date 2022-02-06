extends "res://util/state/state.gd"

var jumps = 0
var max_jumps = 3
var timeout = false
var dir = 0
var jumped = false

func enter():
	timeout = false
	jumps = 0
	dir = 0	
	
func handle(character, controller):
	if controller.target and !character.state.current_state.stunned:
		if character.is_on_wall():
			jumps = max_jumps

		if !dir:
			var dist : Vector2 = controller._target_distance()
			dir = sign(dist.x)
		if character.is_on_floor():
			controller.direction.x = dir
		else:
			controller.direction.x = -dir
		if !timeout: 
			if $Timer.is_stopped():
				$Timer.start()
		elif character.is_on_floor():
			if jumps != max_jumps:
					if !jumped:
						jumped = true
						jumps += 1
					controller.direction.y = 1.0
					controller.buttonC.pressed(true)
					print_debug(jumps, " at state ", character.state.current)
#					timeout = false
			elif !jumped:
					controller.direction.y = 0.0
					controller.buttonC.pressed(true)
					emit_signal("finished","follow", null)
		else:
			jumped = false



func _on_Timer_timeout():
	timeout = true
