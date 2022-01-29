extends State

export var frame_reaction_time := 2
export var dir := 1.0

var frames = 0

func enter():
	frames = 0

func handle(character : KinematicBody2D, controller):
	if character.is_on_wall():
		if !frames:
			dir = -character.dir
		frames = (frames + 1)%frame_reaction_time
	else:
		frames = 0
		dir = character.dir
	controller.direction.x = dir
