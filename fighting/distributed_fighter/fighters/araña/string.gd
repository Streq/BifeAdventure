extends Node2D

export (int, LAYERS_2D_PHYSICS) var terrain_layer

onready var line = $Line2D

onready var start := global_position-Vector2(0,1000)

export (Array, NodePath) var ignore_paths
var ignore := []
func _ready():
	for path in ignore_paths:
		ignore.append(get_node(path))

func _physics_process(delta):
	if visible:
		var space = get_world_2d().direct_space_state
		var start_point : Vector2 = owner.global_position-Vector2(0,1000)
		var intersection = space.intersect_ray(
			owner.global_position, 
			start_point,
			ignore,
			terrain_layer,
			true,
			true
		)
		if intersection:
			start_point = intersection.position
		start = start_point
		line.points = PoolVector2Array([Vector2(), to_local(start)])
		
		
