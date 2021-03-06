extends FighterState

export var _lerp = 1.0

func _physics_update(delta):
	root.velocity.x = lerp(root.velocity.x, 0.0, _lerp*delta)
	if abs(root.velocity.x) < 5.0:
		emit_signal("animation_finished")
