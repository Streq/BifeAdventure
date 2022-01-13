extends "res://util/state/state.gd"

var timeout := false

	
func handle(character, controller):
	if controller.target:
		var dist : Vector2 = controller._target_distance()
		controller.direction.x = sign(dist.x)


func _on_Timer_timeout():
	timeout = true
