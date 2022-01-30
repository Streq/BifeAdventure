extends State

var timer = null
var timeout = false
var started = false
func _init():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout", self, "_timeout")

func enter():
	owner.get_node("AnimationPlayer").play("hitstun")
	owner.emit_signal("hurt")
	timer.wait_time = owner.knockstun
	timeout = false
	started = false
	
func update(delta):
	var p = owner
	p._move(delta, true)
	
	var controller = owner.get_node("controller")
	if timeout:
		owner.emit_signal("regained_control")
		if p.is_on_floor():
			emit_signal("finished", "idle", null)
		else:
			emit_signal("finished", "air", null)
	elif p.is_on_floor():
		p.velocity.x = lerp(p.velocity.x, 0,  delta * p.idle_lerp)
		owner.get_node("AnimationPlayer").play("knocked")
		if !started:
			started = true
			timer.start()

	else:
		p.velocity.x = lerp(p.velocity.x, 0,  delta * p.air_idle_lerp)
		owner.get_node("AnimationPlayer").play("hitstun")
		

func exit():
	timer.stop()

func _timeout():
	timeout = true
