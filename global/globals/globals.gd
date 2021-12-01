extends Node

enum ROOM {
	my_room,
	my_living_room,
	my_hometown,
	my_hometown_basement,
	endurance_round,
	tutorial
}
const TILE_SIZE = 16


var step_counter : int = 0 setget set_step_counter

var spawn_tile = null

func set_step_counter(val):
	step_counter = val
#	print_debug("steps:", val)
