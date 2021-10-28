extends "pawn.gd"

onready var Grid = get_parent()

var flip_vertical_walk = false

func _ready():
	update_look_direction(Vector2(1, 0))

func _process(delta):
	var input_direction = get_input_direction()
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
	pass

func move_to(target_position):
	set_process(false)
	
	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
	

	
	if (move_direction.x>0):
		$AnimationPlayer.play("walk_right")
		$Sprite.flip_h = true
	elif (move_direction.x<0):
		$AnimationPlayer.play("walk_left")
		$Sprite.flip_h = false
	elif (move_direction.y>0):
		$AnimationPlayer.play("walk_down")
		$Sprite.flip_h = !$Sprite.flip_h
	elif (move_direction.y<0):
		$AnimationPlayer.play("walk_up")	
		$Sprite.flip_h = !$Sprite.flip_h
	
	
	$Tween.interpolate_property(
		self,"position",
		position,target_position,
		$AnimationPlayer.current_animation_length,
		Tween.TRANS_LINEAR, Tween.EASE_IN)

	$Tween.start()

	# Stop the function execution until the animation finished
	yield($AnimationPlayer, "animation_finished")
	
	set_process(true)


func bump():
	set_process(false)
	$AnimationPlayer.play("bump")
	yield($AnimationPlayer, "animation_finished")
	set_process(true)
