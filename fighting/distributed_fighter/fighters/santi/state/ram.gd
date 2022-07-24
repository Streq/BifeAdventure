extends FighterState

export var speed := 200.0
export (float, 0.0, 60.0) var speed_lerp := 30.0
export var recoil := Vector2(-100.0, -100.0)

func _physics_update(delta):
	root.velocity.x = lerp(root.velocity.x, root.get_facing_dir()*speed, delta*speed_lerp)
	if root.is_against_wall(1):
		root.velocity = Vector2(recoil.x * root.get_facing_dir(), recoil.y)
		goto("confused")
