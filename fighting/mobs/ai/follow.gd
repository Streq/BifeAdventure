extends State

func handle(character, controller):
	if controller.target:
		var dist : Vector2 = controller._target_distance()
		controller.direction.x = sign(dist.x)
