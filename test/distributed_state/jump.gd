extends Node

export var multiplier := 1.0

onready var direction : Vector2 = $direction.direction if has_node("direction") else Vector2.UP

var strength = 0.0
var pressing = false

func _ready():
	get_parent().connect("animation_finished", self, "jump")
	get_parent().connect("physics_process", self, "physics_process")
	get_parent().connect("entered", self, "entered")
	

func entered():
	strength = 0.0
	pressing = true

func physics_process(delta):
	var fighter = get_parent().root
	var input = fighter.input_state
	if input.A and pressing:
		strength += delta
	else:
		pressing = false
	
	
func jump():
	strength += get_physics_process_delta_time()
	var fighter = get_parent().root
	var strong_jump = fighter.input_state.C
	
	#dirty stuff to get animation length
	var anim_length = fighter.state_animation.get_animation("jump").length
	
	var jump_impulse
	
	if strength < anim_length/2.0:
		#low jump
		jump_impulse = fighter.jump_speed/3
	elif !strong_jump:
		#mid jump
		jump_impulse = fighter.jump_speed*2.0/3
	else:
		#full jump
		jump_impulse = fighter.jump_speed
	var facing_direction = direction
	facing_direction.x *= fighter.get_facing_dir()
	fighter.velocity += jump_impulse*multiplier*facing_direction
