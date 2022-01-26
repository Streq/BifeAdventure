extends Resource

export (Globals.ROOM) var checkpoint_room : int = Globals.ROOM.my_room
export (Globals.ROOM) var current_room : int = Globals.ROOM.my_room
export (Vector2) var spawn_tile = null
export (Globals.EVENT, FLAGS) var event_flags
export var world_position : Vector2 = Vector2.ZERO
export var nodes : Dictionary = {}
