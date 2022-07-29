extends FighterState


export var jumping = true

func _enter(params):
	jumping = true
	$on_floor.enabled = false
	
func _physics_update(delta):
	if jumping:
		root.velocity.x = lerp(root.velocity.x, 0.0, root.idle_lerp*delta)
	elif !root.is_on_floor():
		$on_floor.enabled = true
