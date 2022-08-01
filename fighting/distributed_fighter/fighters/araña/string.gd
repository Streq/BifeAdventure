extends Node2D

export (int, LAYERS_2D_PHYSICS) var terrain_layer

onready var line = $Line2D

func _physics_process(delta):
	if visible:
		var space = get_world_2d().direct_space_state
		var end_point : Vector2 = owner.global_position-Vector2(0,1000)
		var intersection = space.intersect_ray(
			owner.global_position, 
			end_point,[],terrain_layer,
			true,
			true
		)
		if intersection:
			end_point = intersection.position
		line.points = PoolVector2Array([Vector2(), to_local(end_point)])
		
		
