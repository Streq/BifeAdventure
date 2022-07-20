extends FighterState

onready var spawn_point = owner.global_position

func _enter(params):
	yield(get_tree().create_timer(1.0),"timeout")
	root.queue_free()
	
func _physics_update(delta):
	root.velocity = lerp(root.velocity, Vector2.ZERO, delta*root.idle_lerp)
