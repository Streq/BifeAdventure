extends State

export var frame_reaction_time := 2
export var dir := 1.0

var frames = 0
onready var floor_checker = $floor_checker

func enter():
	frames = 0
	floor_checker.scale.x = dir

func handle(character : KinematicBody2D, controller):
	floor_checker.scale.x = dir
	if character.is_on_wall() or (character.is_on_floor() and !floor_checker.get_overlapping_bodies().size()):
		if !frames:
			dir = -character.dir
			
		frames = (frames + 1)%frame_reaction_time
	else:
		frames = 0
		dir = character.dir
	controller.direction.x = dir
