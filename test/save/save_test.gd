extends Node2D


func _ready():
	
	var Savestate = load("res://persistence/save/savestate.gd")
	
	var save = Savestate.new()

	save.checkpoint_room = Globals.ROOM.malovich_house
	save.current_room = Globals.ROOM.hometown_forest
	save.spawn_tile = Vector2(2,3)
	save.event_flags = 3
	save.world_position = Vector2(4,4)

	print(to_json(save))
	
	print(ResourceSaver.save("user://save.res", save))
	
	var save2 = ResourceLoader.load("user://save.res")
	print(to_json(save2))
	pass
