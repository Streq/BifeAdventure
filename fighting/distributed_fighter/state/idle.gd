extends FighterState

func _physics_update(delta: float):
	root.velocity.x = lerp(root.velocity.x, 0, delta*root.idle_lerp)
	
