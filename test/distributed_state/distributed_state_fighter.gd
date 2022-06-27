extends KinematicBody2D

export var health := 100.0
export var gravity := 200.0
export var facing_right := true setget set_facing_right

func set_facing_right(val):
	facing_right = val
	pivot.scale.x = 1.0 if val else -1.0

func turn_around():
	set_facing_right(!facing_right)

var velocity := Vector2()

onready var input_state = $input_state
onready var state_animation = $state_animation
onready var pivot = $pivot

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity)
