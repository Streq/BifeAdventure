extends Sprite

var die = false
var velocity = Vector2()
var vector = Vector2()
func _ready():
	vector = position.normalized()

func die():
	die = true
	velocity = vector * 50.0
	yield(get_tree().create_timer(5.0), "timeout")
	queue_free()
	
func _physics_process(delta):
	if die:
		velocity += vector*delta*50.0
	
	position += velocity*delta
	
