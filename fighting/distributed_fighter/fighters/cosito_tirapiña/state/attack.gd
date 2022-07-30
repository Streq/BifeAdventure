extends FighterState

export var projectile : PackedScene
export var speed := 75.0
export var shoot_point_path : NodePath
onready var shoot_point : Node2D = get_node(shoot_point_path)

func _enter(params):
	pass
func _physics_update(delta):
	pass

func throw():
	var inst = projectile.instance()
	
	get_tree().current_scene.add_child(inst)
	var dir  = Vector2(root.get_facing_dir(), 0.0).rotated(root.global_rotation)
	inst.facing_right = root.facing_right
	inst.velocity = dir*speed
	inst.global_position = shoot_point.global_position
	inst.team = root.team
