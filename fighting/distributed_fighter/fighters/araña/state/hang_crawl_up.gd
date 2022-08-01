extends FighterState

signal capped
export var shortest_string_length := 16.0

func _physics_update(delta):
	root.velocity.y = -50.0
	var start = root.get_node("string").start
	if (start - root.global_position).length_squared()<shortest_string_length*shortest_string_length:
		root.global_position = start+Vector2(0.0,shortest_string_length)
		root.velocity.y = 0.0
		emit_signal("capped")
		goto("hang_idle")
	pass
