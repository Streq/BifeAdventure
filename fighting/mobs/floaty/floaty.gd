extends Node2D


var velocity := Vector2.ZERO

var target = null
var dir = 1.0
enum STATE {IDLE, CHASE, DIE}

var state = STATE.IDLE 

func _ready():
	$hitbox.body = self

func _physics_process(delta):
	dir = sign(velocity.x)
	if !dir:
		dir = 1.0
	match state:
		STATE.IDLE:
			pass
		STATE.DIE:
			pass
		STATE.CHASE:
			velocity += Vector2(target.position - position).normalized()*delta*100
	velocity = lerp(velocity, Vector2.ZERO, delta)
	position += velocity * delta

func _enter_state(_state):
	state = _state
	match _state:
		STATE.CHASE:
			$AnimationPlayer.play("chase")
		STATE.DIE:
			$AnimationPlayer.play("die")

func _on_fov_body_entered(body):
	if body.is_in_group("player"):
		match state:
			STATE.IDLE:
				_enter_state(STATE.CHASE)
				target = body
			_:
				pass


func _on_fov_body_exited(body):
	if body == target:
		match state:
			STATE.CHASE:
				_enter_state(STATE.IDLE)
				target = null
			_:
				pass


func _on_hitbox_area_entered(area):
	if area.owner != self:
		velocity += position.direction_to(area.owner.position)*-100


func _on_hurtbox_area_entered(area):
	if area.body != self and !area.body.is_in_group("mob"):
		area.apply_knockback(self)
		_enter_state(STATE.DIE)

func stop_monitoring():
	$hitbox.set_deferred("monitoring",false)
	$hitbox.set_deferred("monitorable",false)
	$hurtbox.set_deferred("monitoring",false)
	$hurtbox.set_deferred("monitorable",false)
