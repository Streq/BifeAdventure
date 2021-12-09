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
	Globals.ROOM.malovich_fight_room : preload("res://scenes/fighting/malovich/malovich_fight.tscn")
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
