extends KinematicBody2D

var max_health := 100
var speed := 200
var speed_lerp := 2
var idle_lerp := 8
var jump := 200
var gravity := 300

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
