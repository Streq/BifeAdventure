extends FighterState

func _enter(params):
	if root.is_against_wall(1):
		root.facing_right = !root.facing_right

# Called during _physics_process
func _physics_update(delta: float):
	root.velocity.y = lerp(root.velocity.y, 0.0, delta*root.wall_lerp)
	root.velocity.x = -10.0*root.get_facing_dir()

