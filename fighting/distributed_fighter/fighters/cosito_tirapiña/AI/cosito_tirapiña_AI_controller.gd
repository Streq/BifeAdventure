extends Node2D

enum STATE {
	WALK,
	TURN,
	ATTACK,
}
var strategy = STATE.WALK
onready var attack_area = $attack_area
onready var floor_detect = $floor_detect
onready var wall_detect = $wall_detect
onready var attack_cooldown = $attack_cooldown

var attacked = false
var dir
func _ready():
	yield(owner,"ready")
	dir = owner.get_facing_dir()

func _physics_process(delta):
	var state = owner.state.current
	update_strategy(state, delta)
	update_inputs(owner.input_state, state, delta)


	
	pass
func update_strategy(state, delta):
	var floors = floor_detect.get_overlapping_bodies().size()
	var walls = wall_detect.get_overlapping_bodies().size()
	if state.name in ["flinch", "air_flinch", "rebound"]:
		dir = owner.get_facing_dir()
	match strategy:
		STATE.WALK:
			var targets = attack_area.get_overlapping_bodies()
			for target in targets:
				if target.team != owner.team and attack_cooldown.is_stopped():
					strategy = STATE.ATTACK
			if (floors == 0 or walls != 0) and !(state.name in ["air","rebound","flinch","air_flinch"]):
				dir = -dir
				strategy = STATE.TURN
		STATE.TURN:
			if owner.get_facing_dir() == dir:
				strategy = STATE.WALK 
		STATE.ATTACK:
			if !attacked:
				attacked = state.name == "attack"
			if attacked and !(state.name in ["attack"]):
				strategy = STATE.WALK
				attack_cooldown.start()
	
	
func update_inputs(input, state, delta):
	match strategy:
		STATE.WALK:
			if attack_cooldown.is_stopped():
				input.dir.x = dir
			else:
				input.dir.x = 0.0
			input.A.update(false)
			input.B.update(false)
			input.C.update(false)
		STATE.TURN:
			input.dir.x = dir
			input.A.update(false)
			input.B.update(false)
			input.C.update(false)
		STATE.ATTACK:
			input.dir.x = dir
			input.A.update(false)
			input.B.update(!input.B.is_pressed())
			input.C.update(false)
