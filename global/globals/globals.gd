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
onready var DEBUG = false #OS.is_debug_build()
	
enum EVENT {
	tutorial_completed,
	malovich_defeated,
	malovich_defeated_cutscene_over
}

export (ROOM) var checkpoint_room : int = ROOM.my_room
export (ROOM) var current_room : int = ROOM.my_room
export (Vector2) var spawn_tile = null
export (Vector2) var checkpoint_tile = null
export (EVENT, FLAGS) var event_flags : int = 0

var step_counter : int = 0 setget set_step_counter


func get_event(event:int):
	return bool((1<<event)&event_flags)

func set_event(event:int, val:bool):
	event_flags |= 1<<event

func set_step_counter(val):
	step_counter = val
#	print_debug("steps:", val)

func respawn():
	spawn_tile = checkpoint_tile
	goto_room(checkpoint_room)
	

func goto_room(to:int):
	current_room = to
	get_tree().change_scene_to(Overworld.get_room(to))

const SAVE_PATH := "user://save.res"

func load_game():
	var save = ResourceLoader.load(SAVE_PATH)
	
	print_debug("recovered savestate:", to_json(save))
	checkpoint_room = save.checkpoint_room
	current_room = save.current_room
	spawn_tile = save.spawn_tile
	event_flags = save.event_flags
	goto_room(current_room)

func save_game():
	var Savestate = load("res://persistence/save/savestate.gd")
	var s = Savestate.new()
	s.checkpoint_room = checkpoint_room
	s.current_room = current_room
	s.spawn_tile = spawn_tile
	s.event_flags = event_flags
	

	print_debug("savestate to save:", to_json(s))
	
	var err = ResourceSaver.save(Globals.SAVE_PATH, s)
	if !err:
		print_debug("save succeeded")
	else:
		print_debug("save returned status code ",err)
