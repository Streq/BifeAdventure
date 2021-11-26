extends Node

const map = {
	Globals.ROOM.my_room : preload("res://scenes/overworld/my_room.tscn"),
	Globals.ROOM.my_living_room : preload("res://scenes/overworld/my_living_room.tscn"),
	Globals.ROOM.my_hometown : preload("res://test/textbox/texbox_test.tscn"),
	Globals.ROOM.my_hometown_basement : preload("res://test/door/door_test.tscn"),
	Globals.ROOM.endurance_round : preload("res://test/mobs/mobs.tscn")
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
