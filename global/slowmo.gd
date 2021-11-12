extends Node

var update_every_n_frames = 0
var current_frame = 0

func _ready():
	set_physics_process(false)
	pause_mode = Node.PAUSE_MODE_PROCESS

func _input(event):
	if event.is_action_pressed("speed_down"):
		update_every_n_frames += 1
		set_physics_process(true)
	elif event.is_action_pressed("speed_up"):
		update_every_n_frames = max(update_every_n_frames - 1, 0)
		if update_every_n_frames == 0:
			set_physics_process(false)

func _physics_process(delta):
	current_frame = (current_frame + 1) % update_every_n_frames
	get_tree().paused = !current_frame == 0
