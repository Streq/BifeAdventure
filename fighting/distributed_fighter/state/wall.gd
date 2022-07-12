extends FighterState

func _enter(params):
	if root.is_against_wall(1):
		root.facing_right = !root.facing_right

func _exit():
	if root.velocity.x:
		root.facing_right = root.velocity.x>0.0


# Called during _physics_process
func _physics_update(delta: float):
	root.velocity.y = lerp(root.velocity.y, 0.0, delta*root.wall_lerp)
	if root.input_state.get_facing_dir().x <= 0.0:
		root.velocity.x = -10.0*root.get_facing_dir()
	
