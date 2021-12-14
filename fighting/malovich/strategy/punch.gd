extends "res://util/state/state.gd"

var max_punches = 3
var punches = 0
var timeout := true


func enter():
	$cooldown.stop()
	timeout = true
	punches = 0
	
	
func handle(character, controller):
	if controller.target:
		var dist : Vector2= controller._target_distance()
		controller.direction.x = sign(dist.x)
		var length_squared : float = dist.length_squared()
		if(timeout and !character.state.current_state.stunned):
			timeout = false
			controller.buttonB.pressed(true)
			$cooldown.start()
			punches += 1
			if punches == max_punches:
				emit_signal("finished","ram", null)
		


func _on_cooldown_timeout():
	timeout = true
