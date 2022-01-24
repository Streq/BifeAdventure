extends Node2D

func assert_prop_equals(prop, o0, o1):
	assert(o0[prop]==o1[prop])
func _ready():
	
	var Savestate = load("res://persistence/save/savestate.gd")
	
	var s = Savestate.new()

	s.checkpoint_room = Globals.ROOM.malovich_house
	s.current_room = Globals.ROOM.hometown_forest
	s.spawn_tile = Vector2(2,3)
	s.event_flags = 3
	s.world_position = Vector2(4,4)

	print("savestate to save:", to_json(s))
	
	var err = ResourceSaver.save("user://save.res", s)
	if !err:
		print("save succeeded")
	else:
		print_debug("save returned status code ",err)
	
	var s2 = ResourceLoader.load("user://save.res")
	
	print("recovered savestate:", to_json(s2))
	
	assert_prop_equals("checkpoint_room", s, s2)
	assert_prop_equals("current_room", s, s2)
	assert_prop_equals("spawn_tile", s, s2)
	assert_prop_equals("event_flags", s, s2)
	assert_prop_equals("world_position", s, s2)
	
	print("both savestates are equal, persistence works!!")
	
	pass
