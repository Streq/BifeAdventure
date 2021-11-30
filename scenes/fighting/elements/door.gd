extends Area2D

export(Globals.ROOM) var to = Globals.ROOM.my_hometown


func _ready():
	set_process_input(false)

func _on_door_body_entered(body):
	if body.is_in_group("player"):
		set_process_input(true)

func _on_door_body_exited(body):
	if body.is_in_group("player"):
		set_process_input(false)

func _input(event):
	if event.is_action_pressed("A0"):
		Globals.spawn_tile = $spawn_pos.position/Globals.TILE_SIZE
		get_tree().change_scene_to(Overworld.map[to])
