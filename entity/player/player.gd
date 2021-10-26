extends KinematicBody2D


const SPEED = 150


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var input_dir = Vector2(float(Input.is_action_pressed("ui_right"))-float(Input.is_action_pressed("ui_left")), float(Input.is_action_pressed("ui_down"))-float(Input.is_action_pressed("ui_up"))).normalized()
	move_and_slide(input_dir*SPEED)
