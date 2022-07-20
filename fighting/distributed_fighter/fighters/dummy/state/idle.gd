extends FighterState

export var spawn_point_path: NodePath
onready var spawn_point = get_node(spawn_point_path)

func _physics_update(delta):
	root.velocity *= 0.95
	root.velocity += root.global_position.direction_to(spawn_point.value)*delta*root.run_speed
