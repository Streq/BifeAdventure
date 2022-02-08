extends State

export var frame_reaction_time := 2
export var dir := 1.0

var frames = 0

func enter():
	frames = 0

func get_target():
	return get_tree().get_nodes_in_group("player")[0].global_position

func handle(character : KinematicBody2D, controller):
	var dist_to_target = get_target()-character.global_position
	if sign(dist_to_target.x) == sign(character.dir):
		controller.direction = dist_to_target.normalized()
		controller.buttonB.pressed(true)
	else:
		controller.direction.x = sign(dist_to_target.x)
		controller.direction.y = 0.0

