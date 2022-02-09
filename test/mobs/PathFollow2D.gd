extends PathFollow2D


export var mob:PackedScene
export var limit := 0

onready var timer = $Timer

var instances := 0

func _on_Timer_timeout():
	spawn()

func _input(event):
	if event.is_action_pressed("B1"):
		spawn()

func decrease():
	instances-=1
	if timer.is_stopped():
		timer.start()
func spawn():
	instances += 1
	if limit and instances == limit:
		timer.stop()
	self.unit_offset = rand_range(0.0, 1.0)
	var _mob = mob.instance()
	_mob.connect("tree_exited", self, "decrease")
	get_parent().call_deferred("add_child", _mob)
	_mob.set_deferred("global_position", global_position)
