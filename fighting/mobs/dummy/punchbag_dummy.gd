extends Node2D

export var speed := 400.0
export var health := 10.0

var velocity := Vector2.ZERO
var spawn_point := Vector2.ZERO

var target = null
var dir = 1.0
enum STATE {IDLE, HURT, DIE}

var state = STATE.IDLE 

func _ready():
	$hitbox.body = self
	spawn_point = global_position

func _physics_process(delta):
	dir = sign(velocity.x)
	if !dir:
		dir = 1.0
	match state:
		STATE.IDLE:
#			global_position = lerp(global_position, spawn_point, delta*speed)

			velocity *= 0.95
			velocity += global_position.direction_to(spawn_point)*delta*speed
		STATE.DIE:
			pass
		STATE.HURT:
			pass
#		STATE.CHASE:
	velocity = lerp(velocity, Vector2.ZERO, delta)
	global_position += velocity * delta

func _enter_state(_state):
	state = _state
	match _state:
		STATE.DIE:
			$AnimationPlayer.play("die")
		STATE.HURT:
			$AnimationPlayer.play("hurt")

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
		velocity += global_position.direction_to(area.owner.global_position)*-100


func _on_hurtbox_area_entered(area):
	if area.body != self and !area.body.is_in_group("mob"):
		area.apply_knockback(self)
		area.apply_damage(self)
		if health>0:
			_enter_state(STATE.HURT)
		else:
			_enter_state(STATE.DIE)
		

func stop_monitoring():
	$hitbox.set_deferred("monitoring",false)
	$hitbox.set_deferred("monitorable",false)
	$hurtbox.set_deferred("monitoring",false)
	$hurtbox.set_deferred("monitorable",false)


func _on_animation_finished(anim_name):
	match state:
		STATE.HURT:
			_enter_state(STATE.IDLE)
