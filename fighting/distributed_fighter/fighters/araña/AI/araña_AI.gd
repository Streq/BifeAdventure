extends Node2D

onready var enemy_detect = $enemy_detect

enum STATE {
	IDLE,
	ATTACK,
	RETREAT,
	
}
var state = STATE.IDLE

func _physics_process(delta):
	var input = owner.input_state
	match state:
		STATE.IDLE:
			for body in enemy_detect.get_overlapping_bodies():
				if body.team != owner.team:
					state = STATE.ATTACK
					break
		STATE.ATTACK:
			if owner.is_on_floor():
				state = STATE.RETREAT
		STATE.RETREAT:
			if owner.is_on_ceiling():
				state = STATE.IDLE
	match state:
		STATE.RETREAT:
			input.dir.y = -1.0
		STATE.IDLE:
			input.dir.y = 0.0
		STATE.ATTACK:
			input.dir.y = 1.0

func _on_capped():
	if state == STATE.RETREAT:
		state = STATE.IDLE
