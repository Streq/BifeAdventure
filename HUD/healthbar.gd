extends Node


var timer : Timer
var _full := true

func _ready():
	self.visible = false
	owner.connect("health_changed", self, "_on_health_changed")
	
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = false
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", self, "_on_timeout")

func _on_health_changed(val, max_val):
	var current = val/max_val*100.0
	set("value", current)
	var full = get("value") == 100.0
	if val == 0.0:
		self.visible = false
	elif _full != full:
		if !full:
			timer.stop()
			self.visible = true
		else:
			timer.start()
	_full = full
func _on_timeout():
	self.visible = false

	
