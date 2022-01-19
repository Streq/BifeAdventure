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
	malovich_room_right_after_fight,
	hometown_forest
}
const TILE_SIZE = 16
	
enum EVENT {
	tutorial_completed,
	malovich_defeated,
	malovich_defeated_cutscene_over
}

var checkpoint_room : int = ROOM.my_room

var step_counter : int = 0 setget set_step_counter

var spawn_tile = null

export (EVENT, FLAGS) var event_flags

func get_event(event:int):
	return bool((1<<event)&event_flags)

func set_event(event:int, val:bool):
	event_flags |= 1<<event

func set_step_counter(val):
	step_counter = val
#	print_debug("steps:", val)

func respawn():
	spawn_tile = null
	goto_room(checkpoint_room)
	

func goto_room(to):
	get_tree().change_scene_to(Overworld.get_room(to))
