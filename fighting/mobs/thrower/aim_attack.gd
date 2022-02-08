extends State

export var frame_reaction_time := 2
export var dir := 1.0

var frames = 0

func enter():
	frames = 0

func get_target():
	return get_tree().get_nodes_in_group("player")[0].global_position

func handle(character : KinematicBody2D, controller):
	var angle = (get_target()-character.global_position).angle()
	controller.direction.x = cos(angle)
	controller.direction.y = sin(angle)
	controller.buttonB.pressed(true)

	
	
