extends FighterState

func _physics_update(delta):
	root.velocity.x = lerp(root.velocity.x, root.get_facing_dir()*root.run_speed, delta*root.run_lerp)
