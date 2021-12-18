extends PathFollow2D


export var mob:PackedScene
export var limit := 0
var instances := 0

func _on_Timer_timeout():
	spawn()

func _input(event):
	if event.is_action_pressed("B1"):
		spawn()

func spawn():
	instances += 1
	if limit and instances == limit:
		$Timer.stop()
	self.unit_offset = rand_range(0.0, 1.0)
	var _mob = mob.instance()
	get_parent().get_parent().call_deferred("add_child", _mob)
	_mob.set_deferred("global_position", global_position)
