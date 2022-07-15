extends Sprite

var die = false
var has_died = false
var velocity = Vector2()
var vector = Vector2()

func die():
	die = true
	yield(get_tree().create_timer(5.0), "timeout")
	queue_free()
	
func _physics_process(delta):
	if die:
		if !has_died:
			velocity = vector * 50.0
			has_died = true
		velocity += vector*delta*50.0
	
	position += velocity*delta
	


func _on_box_tree_entered():
	vector = -global_position.normalized()
	
