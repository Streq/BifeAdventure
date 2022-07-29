extends FighterState

export var projectile : PackedScene

func _enter(params):
	pass
func _physics_update(delta):
	pass

func throw():
	var inst = projectile.instance()
	
	inst.dir = Vector2(root.get_facing_dir(), 0.0)
	get_tree().current_scene.add_child(inst)
	inst.global_position = root.global_position
	
