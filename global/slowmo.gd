extends Node

var update_every_n_frames = 1
var current_frame = 0

var input_queue := []

func _ready():
	set_physics_process(false)
	pause_mode = Node.PAUSE_MODE_PROCESS
	process_priority = -10

func _input(event):
	if event.is_action_pressed("speed_down"):
		update_every_n_frames += 1
		set_physics_process(true)
	elif event.is_action_pressed("speed_up"):
		update_every_n_frames = max(update_every_n_frames - 1, 1)
		if update_every_n_frames == 1:
			get_tree().paused = false
			set_physics_process(false)
	elif event.is_action_type() and get_tree().paused:
		input_queue.push_back(event)

func _physics_process(delta):
	current_frame = (current_frame + 1) % update_every_n_frames
	get_tree().paused = !current_frame == 0
	if current_frame == 0:
		set_process_input(false)
		for input in input_queue:
			Input.parse_input_event(input)
		input_queue.clear()
	else:
		set_process_input(true)
