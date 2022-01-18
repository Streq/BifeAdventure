extends KinematicBody2D

signal health_changed(val, max_health)

signal dead()
signal hurt()
signal regained_control()

export var team :int = 0
export var max_health :float = 100
export var speed :float = 300
export var speed_lerp :float = 2
export var air_speed_lerp :float = 1
export var idle_lerp :float = 8
export var air_idle_lerp :float = 1
export var jump :float = 200
export var wall_jump :float = 200
export var gravity :float = 400
export var hitstun :float = 0.3

onready var state = $state
onready var sprite = $Sprite
onready var controller = $controller
onready var attack_list = $attack_list


var _break = true

export var dir = 1.0

onready var health := max_health setget set_health
var velocity := Vector2.ZERO
func _input(event):
	if event.is_action_pressed("A1"):
		health = max(health,0)
		set_health(0)
		health = min(health,max_health)


func _move(delta, bounce_h = false, bounce_y = false):
	velocity.y += gravity*delta
	var aux_vel = velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	if bounce_y and (is_on_floor() or is_on_ceiling()):
		velocity.y = -aux_vel.y
	if bounce_h and is_on_wall():
		velocity.x = -aux_vel.x
		dir = -dir
	sprite.flip_h = dir < 0.0
	

func _on_hurtbox_area_entered(area):
	if !area.is_whitelisted(self):
		var hitter = area.body
		if area.get_knockdown():
			state._change_state("knocked",null)
		else:
			state._change_state("hitstun",null)
		area.apply_knockback(self)		
		area.apply_damage(self)
		
	
func set_health(val):
	health = val
	emit_signal("health_changed", val, max_health)
	if health <= 0:
		state._change_state("dead", null)
		emit_signal("dead")
		
func learn(attack):
	attack_list.add_child(attack)

func unlearn(attack):
	attack_list.remove_child(attack)
