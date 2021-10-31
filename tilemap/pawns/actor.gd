extends "pawn.gd"

onready var Grid = get_parent()

var flip_vertical_walk = false
var look_dir : Vector2

onready var anim = $character_sprite/AnimationPlayer

func _ready():
	update_look_direction(Vector2.DOWN)

func _process(delta):
	var input_direction = get_input_direction()
	var interact = Input.is_action_just_pressed("A")
	if interact:
		Grid.request_interact(self, look_dir)
	
	if not input_direction:
		return
	update_look_direction(input_direction)

	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
	else:
		bump()

func get_input_direction():
	var ret = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)
	if ret.x:
		ret.y = 0
	return ret

func update_look_direction(direction):
#	$Sprite.rotation = direction.angle()
	look_dir = direction
	pass

func move_to(target_position):
	set_process(false)
	
	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
	

	
	if (move_direction.x>0):
		anim.play("walk_right")
	elif (move_direction.x<0):
		anim.play("walk_left")
	elif (move_direction.y>0):
		anim.play("walk_down")
	elif (move_direction.y<0):
		anim.play("walk_up")
	
	
	$Tween.interpolate_property(
		self,"position",
		position,target_position,
		anim.current_animation_length,
		Tween.TRANS_LINEAR, Tween.EASE_IN)

	$Tween.start()

	# Stop the function execution until the animation finished
	yield(anim, "animation_finished")
	
	set_process(true)


func bump():
	set_process(false)
	match look_dir:
		Vector2.DOWN:
			anim.play("idle_down")
		Vector2.UP:
			anim.play("idle_up")
		Vector2.LEFT:
			anim.play("idle_left")
		Vector2.RIGHT:
			anim.play("idle_right")
#	anim.play("bump")
	yield(anim, "animation_finished")
	set_process(true)
