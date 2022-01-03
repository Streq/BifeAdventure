extends Node

enum ROOM {
	my_room,
	my_living_room,
	my_hometown,
	my_hometown_basement,
	endurance_round,
	tutorial,
	pepe_house,
	malovich_house,
	malovich_fight_room,
	malovich_room,
}
const TILE_SIZE = 16

enum EVENT {
	tutorial_completed,
	malovich_defeated
}

var step_counter : int = 0 setget set_step_counter

var spawn_tile = null

var events : = {}

func set_step_counter(val):
	step_counter = val
#	print_debug("steps:", val)

