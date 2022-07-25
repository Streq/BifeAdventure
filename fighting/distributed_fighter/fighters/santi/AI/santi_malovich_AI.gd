extends Node

signal strategy_changed(name)

export var enabled : bool = true setget set_enabled

var body
var input : InputState = null

export var target_path : NodePath

onready var target : Fighter = get_node(target_path) if target_path else null

enum STRATEGY {
	JAB,
	RAM,
	WALK_AROUND,
}


var strategy : int = STRATEGY.WALK_AROUND
var dir : float = 1.0


func _ready():
	body = get_parent()
	input = body.input_state
	body.connect("ready", self, "_initialize")
	add_child(walk_timer)
	change_strategy(STRATEGY.WALK_AROUND)

func _initialize():
	body = get_parent()
	input = body.input_state

func _enter_tree():
	body = get_parent()
	input = body.input_state
	
	
func set_enabled(val):
	set_physics_process(val)
	if enabled!=val:
		enabled = val
		if enabled:
			#to prevent jumping at the end of a dialog
			update_inputs()
			input.clear_updated()
		else:
			input.clear()

var jabs = 0
var max_jabs = 3
var jumps = 0
var max_jumps = 3
var rammed = false
var confusion_started = false

onready var walk_timer = Timer.new()


func _physics_process(delta):
	var dist = target.global_position - body.global_position
	dir = sign(dist.x)
	var length = abs(dist.x)
	var state = body.state.current.name
	match strategy:
		STRATEGY.WALK_AROUND:
			if walk_timer.is_stopped():
				change_strategy(STRATEGY.JAB)
		STRATEGY.JAB:
			if jabs >= max_jabs:
				change_strategy(STRATEGY.RAM)
		STRATEGY.RAM:
			if !confusion_started:
				confusion_started = jumps >= max_jumps and state in ["confused", "rebound", "flinch", "hurt"]
			if confusion_started and state != "confused":
				change_strategy(STRATEGY.WALK_AROUND)
			pass
	
	
	
	update_inputs()


func change_strategy(new_strat):
	strategy = new_strat
	match strategy:
		STRATEGY.WALK_AROUND:
			walk_timer.start(3.0)
			walk_timer.one_shot = true
			pass
		STRATEGY.JAB:
			jabs = 0
			pass
		STRATEGY.RAM:
			jumps = 0
			confusion_started = false
			pass
	emit_signal("strategy_changed",STRATEGY.keys()[strategy])

func update_inputs():
	var current = body.state.current
	var state = body.state.current.name
	input.dir.x = dir
	input.dir.y = 0.0
	match strategy:
		STRATEGY.WALK_AROUND:
			input.A.update(false)
			input.B.update(false)
			input.C.update(false)
		STRATEGY.JAB:
			match state:
				"idle","air","walk":
					input.A.update(false)
					if !input.B.is_pressed() and body.get_facing_dir() == dir:
						input.B.update(true)
						jabs += 1
					else:
						input.B.update(false)
					input.C.update(false)
				_:
					input.A.update(false)
					input.B.update(false)
					input.C.update(false)
		STRATEGY.RAM:
			input.dir.y = 1.0
			input.dir.x = 0.0 if body.get_facing_dir() == dir else dir
			match state:
				"idle":
					if body.get_facing_dir() == dir:
						if jumps < max_jumps:
							if !input.A.is_pressed():
								jumps += 1
								input.A.update(true)
							else:
								input.A.update(false)
							input.B.update(false)
							
						else:
							input.A.update(false)
							input.B.update(!input.B.is_pressed())
				"jump","air":
					
					input.A.update(false)
					input.B.update(false)
				_:
					input.A.update(false)
					input.B.update(false)
					input.C.update(true)
