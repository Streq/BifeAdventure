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



func target_out_of_sight():
	current = peace
	pass
	
func target_sneaked_past():
	pass
