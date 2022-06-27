extends KinematicBody2D

export var health := 100.0
export var gravity := 200.0

var velocity := Vector2()

onready var input_state = $input_state

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity)
