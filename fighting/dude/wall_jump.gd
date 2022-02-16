extends "res://util/state/state.gd"


export var angle_up := 60.0
export var angle_neutral := 45.0
export var angle_down := -45.0

onready var jump_vec_up := Vector2(cos(deg2rad(angle_up)),sin(deg2rad(angle_up)))
onready var jump_vec_neutral := Vector2(cos(deg2rad(angle_neutral)),sin(deg2rad(angle_neutral)))
onready var jump_vec_down := Vector2(cos(deg2rad(angle_down)),sin(deg2rad(angle_down)))

var frame_counter := 0
var charge_counter := 0
const duration_frames := 3

var half_jump_factor := 1

func enter():
	frame_counter = 0
	charge_counter = 0
	
func update(delta):
	var p = owner
	p._move(delta)	
	
	var controller = p.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	
	
	# stick to the wall
	p.velocity.x = lerp(p.velocity.x, p.dir, delta * p.speed_lerp * 0.5)
	
	frame_counter += 1
	if controller.is_pressing_jump():
		charge_counter += 1
	
	if !p.is_on_wall() or frame_counter > duration_frames:
		emit_signal("finished", "air", null)
	elif frame_counter == duration_frames:
		p.dir = -p.dir
		var jump_vec
		match input_direction.y:
			-1.0: 
				jump_vec = jump_vec_up
			0.0: 
				jump_vec = jump_vec_neutral
			1.0: 
				jump_vec = jump_vec_down
				
		jump_vec *= Vector2(p.dir, -1) * p.wall_jump
		
		if charge_counter < frame_counter:
			jump_vec *= half_jump_factor
		
		p.velocity += jump_vec
