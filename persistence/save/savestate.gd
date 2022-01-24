extends Resource

export (Globals.ROOM) var checkpoint_room : int = Globals.ROOM.my_room
export (Globals.ROOM) var current_room : int = Globals.ROOM.my_room
export (Vector2) var spawn_tile = null
export (Globals.EVENT, FLAGS) var event_flags
export var world_position : Vector2 = Vector2.ZERO

func _to_string():
	var ret = "Savestate("
	var i = 0
	var props = get_property_list()
	var lp = props.pop_back()
	for p in props:
		ret += p.name + ":" + str(self.get(p.name)) + ', '
	ret += lp.name + ":" + str(self.get(lp.name)) + ")"
	
	return ret
