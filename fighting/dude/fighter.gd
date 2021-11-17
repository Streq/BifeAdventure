extends KinematicBody2D

signal health_changed(val)

export var max_health :float = 100
export var speed :float = 300
export var speed_lerp :float = 2
export var air_speed_lerp :float = 1
export var idle_lerp :float = 8
export var air_idle_lerp :float = 1
export var jump :float = 200
export var wall_jump :float = 200
export var gravity :float = 400

onready var state = $state
onready var sprite = $Sprite
onready var controller = $controller


var _break = true

var dir = 1.0

var health := max_health setget set_health
var velocity := Vector2.ZERO



func _move(delta):
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity, Vector2.UP)
	sprite.flip_h = dir < 0.0
	if is_on_floor() and velocity.y > 0 or is_on_ceiling() and velocity.y < 0:
		velocity.y = 0
	if is_on_wall():
		velocity.x = 0


func _on_hurtbox_area_entered(area):
	if area.owner != self:
		state._change_state("hurt",null)
		velocity += area.knockback
		health -= area.damage
	
func set_health(val):
	health = val
	emit_signal("health_changed",val)
