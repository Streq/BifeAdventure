extends Node

enum ROOM {
	my_room,
	my_living_room,
	my_hometown,
	my_hometown_basement,
	endurance_round,
	tutorial,
	pepe_house
}
const TILE_SIZE = 16

enum EVENTS {
	tutorial_completed
}

var step_counter : int = 0 setget set_step_counter

var spawn_tile = null

var things_that_happened : = {}

func set_step_counter(val):
	step_counter = val
#	print_debug("steps:", val)
