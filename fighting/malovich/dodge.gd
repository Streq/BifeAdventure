extends "res://util/state/state.gd"

var first_frame = true
var timer = null
var timeout = false
export var duration := 0.1
export var jump_force := Vector2.ZERO

func _init():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout", self, "_timeout")


func enter():
	timeout = false
	owner.get_node("AnimationPlayer").play("air")
	first_frame = true
	timer.wait_time = duration
	timer.start()
	
	var p = owner
	p.velocity.y = jump_force.y
	p.velocity.x = p.dir*jump_force.x
	p.deactivate_hurtbox("main")

func update(delta):
	
	var p = owner
	p._move(delta)
	
	if p.is_on_floor():
		emit_signal("finished", "idle", null)
	elif timeout:
		emit_signal("finished", "air", null)

func exit():
	var p = owner
	p.hurtbox.clear()

func _timeout():
	timeout = true
