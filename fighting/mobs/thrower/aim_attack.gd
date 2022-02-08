extends State

export var frame_reaction_time := 2
export var dir := 1.0

var frames = 0

var start_attacking = false
onready var timer = $Timer
func enter():
	frames = 0
	start_attacking = false
	timer.start()

func get_target():
	return get_tree().get_nodes_in_group("player")[0].global_position

func handle(character : KinematicBody2D, controller):
	if start_attacking:
		var dist_to_target = get_target()-character.global_position
		if sign(dist_to_target.x) == sign(character.dir):
			controller.direction = dist_to_target.normalized()
			controller.buttonB.pressed(true)
		else:
			controller.direction.x = sign(dist_to_target.x)
			controller.direction.y = 0.0
	else:
		controller.direction = Vector2.ZERO


func _on_Timer_timeout():
	start_attacking = true
