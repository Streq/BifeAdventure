extends FighterState

func _physics_update(delta: float):
	if root.is_on_floor():
		root.velocity.x = lerp(root.velocity.x, 0, delta*root.idle_lerp)
	
