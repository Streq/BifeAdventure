extends "res://overworld/tilemap/pawns/pawn.gd"

signal start_step()
signal finish_step()


onready var Grid = get_parent()
onready var anim = $character_sprite/AnimationPlayer
onready var controller = $controller
onready var interact_action = $interact_action if has_node("interact_action") else null
onready var tween = $Tween


var flip_vertical_walk = false
var look_dir : Vector2
var moving := false

export (float) var speed := 1.0 setget set_speed


func _ready():
	update_look_direction(Vector2.DOWN)
	self.speed = speed
	
func interact(pawn, direction):
	if interact_action:
		interact_action.interact(self, pawn, direction)
	
func _process(delta):
	if moving:
		return
	var move_direction = controller.get_direction(self)
	var interact = controller.get_interact(self)
	if interact:
		Grid.request_interact(self, look_dir)
	
	if not move_direction:
		return
	update_look_direction(move_direction)

	var target_position = Grid.request_move(self, move_direction)
	if target_position:
		move_to(target_position)
	else:
		bump()


func update_look_direction(direction):
	look_dir = direction
	pass

func move_to(target_position):
	moving = true
	emit_signal("start_step")
	
	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position)
	
	if (move_direction.x>0):
		anim.play("walk_right")
	elif (move_direction.x<0):
		anim.play("walk_left")
	elif (move_direction.y>0):
		anim.play("walk_down")
	elif (move_direction.y<0):
		anim.play("walk_up")
	
	
	tween.interpolate_property(
		self,"position",
		position,target_position,
		anim.current_animation_length / anim.get_playing_speed(),
		Tween.TRANS_LINEAR, Tween.EASE_IN)

	tween.start()

	# Stop the function execution until the animation finished
	yield(tween, "tween_all_completed")
	
	
	emit_signal("finish_step")
	moving = false
	


func bump():
	moving = true
	match look_dir:
		Vector2.DOWN:
			anim.play("idle_down")
		Vector2.UP:
			anim.play("idle_up")
		Vector2.LEFT:
			anim.play("idle_left")
		Vector2.RIGHT:
			anim.play("idle_right")
	yield(anim, "animation_finished")
	moving = false
func turn(direction):
	look_dir = direction
	match direction:
		Vector2.DOWN:
			anim.play("idle_down")
		Vector2.UP:
			anim.play("idle_up")
		Vector2.LEFT:
			anim.play("idle_left")
		Vector2.RIGHT:
			anim.play("idle_right")


func set_speed(val):
	speed = val
	$character_sprite/AnimationPlayer.playback_speed = val
	
