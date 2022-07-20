extends FighterState

onready var spawn_point = owner.global_position

func _physics_update(delta):
	root.velocity *= 0.95
	root.velocity += root.global_position.direction_to(spawn_point)*delta*root.run_speed
