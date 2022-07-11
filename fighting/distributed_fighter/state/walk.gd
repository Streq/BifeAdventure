extends FighterState



func _physics_update(delta):
	root.velocity.x = lerp(root.velocity.x, root.get_facing_dir()*root.walk_speed, delta*root.walk_lerp)
