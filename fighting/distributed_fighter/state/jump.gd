extends FighterState

#how much it takes for the jump to conclude
export var jump_lag := 0.0
export var additive_velocity := true 

# [[1.0,1.0],[0.6,0.8],[0.2,0.5],[0.0,0.1]]
# press >= 1.0 seconds -> 1.0 times the jump_speed
# press >= 0.6 seconds -> 0.8 times the jump_speed
# press >= 0.2 seconds -> 0.5 times the jump_speed
# press >= 0.0 seconds -> 0.1 times the jump_speed
export (Array, Array, float) var jump_config

onready var jump_lag_timer = $jump_lag
onready var jump_charge = $jump_charge
onready var direction = $direction

onready var on_finish = $on_finish

var pressing = false
var jump_factor := 0.0

#for AI's
var chosen_config = -1

var anim_finished = false 
func _ready():
	jump_lag_timer.connect("timeout", self, "jump")

func _enter(params):
	on_finish.enabled = false
	anim_finished = false
	pressing = true
	jump_factor = 0.0
	jump_lag_timer.wait_time = jump_lag
	jump_charge.wait_time = jump_lag
	jump_lag_timer.start()
	
	jump_charge.paused=false
	jump_charge.start()
	


func _exit():
	jump_lag_timer.stop()
	jump_charge.stop()

func _physics_update(delta):
	pressing = pressing and root.input_state.A.is_pressed()
	if !pressing:
		jump_charge.paused=true

func _on_animation_finished(name):
	anim_finished = true
	

func jump():
	var jump_speed : float = root.jump_speed
	var press_time = jump_lag - jump_charge.time_left
	if chosen_config != -1:
		jump_factor = jump_config[chosen_config][1]
	else:
		for config in jump_config:
			var config_press_req = config[0]*jump_lag
			var config_jump_factor = config[1]
			
			if press_time >= config_press_req:
				jump_factor = config_jump_factor
				break
	var velocity = direction.direction * Vector2(root.get_facing_dir(), 1.0) * jump_speed * jump_factor
	if additive_velocity:
		root.velocity += velocity
	else:
		root.velocity = velocity
	if anim_finished:
		goto("air")
	else:
		on_finish.enabled = true
	
#	goto("air")

