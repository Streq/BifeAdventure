extends KinematicBody2D
signal health_changed(value, nax_value)


export var health := 100.0
export var max_health := 100.0
export var gravity := 200.0
export var facing_right := true setget set_facing_right
export var walk_speed := 100.0
export var run_speed := 200.0
export var jump_speed := 200.0
export (float, 0.0, 1000.0) var knockback_resistance := 0.0
#multiplies received knockback by this value
export (float, 0.0, 10.0) var knockback_lightness_multiplier := 1.0
export (float, 0.0, 10.0) var flinch_multiplier := 0.1

onready var input_state = $input_state
onready var state_animation = $state_animation
onready var state = $state_machine

onready var pivot = $pivot

var flinch_frames := 0


func _ready():
	state_animation.play("RESET")
	state_animation.advance(0)

func set_facing_right(val):
	facing_right = val
	pivot.scale.x = 1.0 if val else -1.0

func get_facing_dir():
	return 1.0 if facing_right else -1.0

func turn_around():
	set_facing_right(!facing_right)

var velocity := Vector2()

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y += gravity * delta
	flinch_frames = max(0, flinch_frames-1)

enum H_COLLISION_SIDE {
	ANY = 0,
	BACKWARDS = -1,
	FORWARD = 1
}
func is_against_wall(side: int):
	if side == H_COLLISION_SIDE.ANY:
		return is_on_wall()
	
	if is_on_wall():
		var modifier
		if side == H_COLLISION_SIDE.FORWARD:
			modifier = -1.0
		else:
			modifier = 1.0
		for i in get_slide_count():
			var collision : KinematicCollision2D = get_slide_collision(i)
			if sign(collision.normal.x) == modifier*get_facing_dir():
				return true
		return false

func receive_knockback(knockback: Vector2):
	knockback *= knockback_lightness_multiplier
	var power = knockback.length()
	if power > knockback_resistance:
		velocity = knockback*(1.0 - knockback_resistance/power)

func flinch(knockback: Vector2):
	knockback *= knockback_lightness_multiplier
	var power = max(0,knockback.length() - knockback_resistance)
	if knockback.x:
		set_facing_right(!(knockback.x>0.0))
	flinch_frames = int(power*flinch_multiplier)
	state._change_state("flinch", null)
	
func receive_damage(damage : float):
	health = clamp(health - damage, 0.0, max_health)
	emit_signal("health_changed", health, max_health)
