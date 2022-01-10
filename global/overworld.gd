extends Node

const map = {
	Globals.ROOM.my_room : preload("res://scenes/overworld/my_room.tscn"),
	Globals.ROOM.my_living_room : preload("res://scenes/overworld/my_living_room.tscn"),
	Globals.ROOM.my_hometown : preload("res://scenes/overworld/hometown.tscn"),
	Globals.ROOM.my_hometown_basement : preload("res://test/door/door_test.tscn"),
	Globals.ROOM.endurance_round : preload("res://test/mobs/mobs.tscn"),
	Globals.ROOM.tutorial : preload("res://scenes/fighting/tutorial.tscn"),
	Globals.ROOM.pepe_house : preload("res://scenes/overworld/casa_pepe.tscn"),
	Globals.ROOM.malovich_house : preload("res://scenes/overworld/malovich_living_room.tscn"),
	Globals.ROOM.malovich_room : preload("res://scenes/overworld/malovich_room.tscn"),
	Globals.ROOM.malovich_room_right_after_fight : preload("res://scenes/overworld/malovich_room_right_after_fight/scene.tscn"),
	Globals.ROOM.malovich_fight_room : preload("res://scenes/fighting/malovich/malovich_fight.tscn")
}

func get_room(room:int, consider_events := true):
	if !consider_events:
		return map[room]
	else: #custom room logic
		match room:
			Globals.ROOM.malovich_room:
				if Globals.get_event(Globals.EVENT.malovich_defeated):
					return map[Globals.ROOM.malovich_room_right_after_fight]
				else: 
					return map[Globals.ROOM.malovich_room]
				
		return map[room]
