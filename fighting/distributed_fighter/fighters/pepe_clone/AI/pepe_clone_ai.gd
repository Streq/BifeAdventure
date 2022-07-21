extends Node

export var flip_h : bool = false
export var enabled : bool = true setget set_enabled

var body
var input : InputState = null

export var target_path : NodePath

onready var target : Fighter = get_node(target_path) if target_path else null

enum STATE {
	LOW_JUMP,
	MID_JUMP,
	HIGH_JUMP,
	ATTACK
}

var state : int = STATE.LOW_JUMP
var dir : float = 1.0


func _ready():
	body = get_parent()
	input = body.input_state
	body.connect("ready", self, "_initialize")

func _initialize():
	body = get_parent()
	input = body.input_state

func _enter_tree():
	body = get_parent()
	input = body.input_state
	
	
func set_enabled(val):
	enabled = val
	set_physics_process(enabled)
	if enabled:
		#to prevent jumping at the end of a dialog
		update_inputs()
		input.clear_updated()
	if !enabled:
		input.clear()
	
func _physics_process(delta):
	var dist = target.global_position - body.global_position
	dir = sign(dist.x)
	var length = abs(dist.x)
	
	if $hit_detect.overlaps_body(target):
		state = STATE.ATTACK
	elif $low_jump_detect.overlaps_body(target):
		state = STATE.LOW_JUMP
	elif $mid_jump_detect.overlaps_body(target):
		state = STATE.MID_JUMP
	else: 
		state = STATE.HIGH_JUMP
	update_inputs()


func update_inputs():
	var current = body.state.current
	input.dir.x = dir
	match state:
		STATE.LOW_JUMP:
			match current.name:
				"idle":
					input.A.update(body.get_facing_dir() == dir)
					input.B.update(false)
					input.C.update(false)
				"front_jump":
					current.chosen_config = 2
				_:
					input.A.update(false)
					input.B.update(false)
					input.C.update(false)
		STATE.MID_JUMP:
			match current.name:
				"idle":
					input.A.update(body.get_facing_dir() == dir)
					input.B.update(false)
					input.C.update(false)
				"front_jump":
					current.chosen_config = 1
				_:
					input.A.update(false)
					input.B.update(false)
					input.C.update(false)
		STATE.HIGH_JUMP:
			match current.name:
				"idle":
					input.A.update(body.get_facing_dir() == dir)
					input.B.update(false)
					input.C.update(false)
				"front_jump":
					current.chosen_config = 0
				_:
					input.A.update(false)
					input.B.update(false)
					input.C.update(false)
		STATE.ATTACK:
			match current.name:
				"idle","air":
					input.A.update(false)
					input.B.update(body.get_facing_dir() == dir)
					input.C.update(false)
				_:
					input.A.update(false)
					input.B.update(false)
					input.C.update(false)
#	input.A.update(Input.is_action_pressed("A0"))
#	input.B.update(Input.is_action_pressed("B0"))
#	input.C.update(Input.is_action_pressed("C0"))
#
#	input.dir.x = float(Input.is_action_pressed("right0")) - float(Input.is_action_pressed("left0"))
#	if flip_h:
#		input.dir.x *= -1.0
#	input.dir.y = float(Input.is_action_pressed("down0")) - float(Input.is_action_pressed("up0"))
	
