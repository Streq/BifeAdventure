extends "res://util/state/state.gd"

export var angle_up := 0.0
export var angle_neutral := 0.0
export var angle_down := 0.0

onready var jump_vec_up := Vector2(cos(deg2rad(angle_up)),sin(deg2rad(angle_up)))
onready var jump_vec_neutral := Vector2(cos(deg2rad(angle_neutral)),sin(deg2rad(angle_neutral)))
onready var jump_vec_down := Vector2(cos(deg2rad(angle_down)),sin(deg2rad(angle_down)))

func enter():
	owner.get_node("AnimationPlayer").play("wall")

func update(delta):
	var p = owner
	p._move(delta)	
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	
	p.velocity.x = lerp(p.velocity.x, p.speed*input_direction.x, delta * p.speed_lerp * 0.5)
	p.velocity.y = lerp(p.velocity.y, 0, delta*5)
	# stick to the wall
	p.velocity.x = lerp(p.velocity.x, p.dir, delta * p.speed_lerp * 0.5)

	
	if p.is_on_floor():
		emit_signal("finished", "idle", null)
	elif !p.is_on_wall():
		emit_signal("finished", "air", null)
	elif jump:
		p.dir = -p.dir
		var jump_vec
		match input_direction.y:
			-1.0: 
				jump_vec = jump_vec_up
			0.0: 
				jump_vec = jump_vec_neutral
			1.0: 
				jump_vec = jump_vec_down
		p.velocity += Vector2(p.dir, -1) * jump_vec * p.wall_jump
