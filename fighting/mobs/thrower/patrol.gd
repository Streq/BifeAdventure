extends State

export var frame_reaction_time := 2
export var dir := 1.0

onready var peace = $walk_around
onready var attack = $aim_attack
onready var sight = $sight
onready var current = peace


func handle(character : KinematicBody2D, controller):
	sight.scale.x = character.dir
	return current.handle(character, controller)

func _on_sight_body_entered(body):
	if body.is_in_group("player"):
		current.exit()
		current = attack
		current.enter()

func _on_sight_body_exited(body):
	if body.is_in_group("player"):
		current.exit()
		current = peace
		current.enter()
