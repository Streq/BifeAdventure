extends FighterState

var timer := Timer.new()

func _ready():
	timer.wait_time = 3.0
	timer.autostart = false
	timer.one_shot = true
	add_child(timer)

# Initialize the state. E.g. change the animation
func _enter(params):
	timer.connect("timeout", root, "queue_free")
	timer.start()
	root.gravity = 100.0
	root.collision_layer = 0
	root.collision_mask = 0
	root.velocity = Vector2(-root.get_facing_dir()*50.0, -50.0)
	
# Clean up the state. Reinitialize values like a timer
func _exit():
	return

# Called during _process
func _idle_update(delta: float):
	return

# Called during _physics_process
func _physics_update(delta: float):
	return

# Called during _input
func _handle_input(event: InputEvent):
	return
