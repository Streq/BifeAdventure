extends KinematicBody2D

export var max_health :float = 100
export var speed :float = 300
export var speed_lerp :float = 2
export var air_speed_lerp :float = 1
export var idle_lerp :float = 8
export var air_idle_lerp :float = 1
export var jump :float = 200
export var wall_jump :float = 200
export var gravity :float = 400

var _break = true

var dir = 1.0

var health := max_health
var velocity := Vector2.ZERO



func _move(delta):
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity, Vector2.UP)
	$Sprite.flip_h = dir < 0.0
	if is_on_floor() and velocity.y > 0 or is_on_ceiling() and velocity.y < 0:
		velocity.y = 0
	if is_on_wall():
		velocity.x = 0
