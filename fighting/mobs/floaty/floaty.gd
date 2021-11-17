extends Node2D


var velocity := Vector2.ZERO
var target = null

enum STATE {IDLE, CHASE, DIE}

var state = STATE.IDLE 

func _physics_process(delta):
	match state:
		STATE.IDLE:
			pass
		STATE.DIE:
			pass
		STATE.CHASE:
			velocity += Vector2(target.position - position).normalized()*delta*100
	velocity = lerp(velocity, Vector2.ZERO, delta)
	position += velocity * delta

func _on_fov_body_entered(body):
	if body.is_in_group("player"):
		match state:
			STATE.IDLE:
				state = STATE.CHASE
				target = body
			_:
				pass


func _on_fov_body_exited(body):
	if body == target:
		match state:
			STATE.CHASE:
				state = STATE.IDLE
				target = null
			_:
				pass


func _on_hitbox_area_entered(area):
	if area.owner != self:
		velocity += Vector2(1,-1)*-50


func _on_hurtbox_area_entered(area):
	if area.owner != self:
		velocity += Vector2(1,1)*+50
		STATE.DIE
