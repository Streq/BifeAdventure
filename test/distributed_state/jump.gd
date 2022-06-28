extends Node

func _ready():
	get_parent().connect("animation_finished", self, "jump")
	get_parent().connect("physics_process", self, "physics_process")
	get_parent().connect("entered", self, "entered")
var strength = 0.0
var pressing = false
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
	
	var fighter = get_parent().root
	#dirty stuff to get animation length
	var anim_length = fighter.state_animation.get_animation("jump").length-get_physics_process_delta_time()
	
	var jump_impulse
	
	if strength < anim_length/3.0:
		#low jump
		jump_impulse = fighter.jump_speed/3
	elif strength < anim_length*0.9:
		#mid jump
		jump_impulse = fighter.jump_speed*2.0/3
	else:
		#full jump
		jump_impulse = fighter.jump_speed

	fighter.velocity.y -= jump_impulse
