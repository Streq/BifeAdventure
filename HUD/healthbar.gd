extends Node


onready var timer := Timer.new()
var _full := true
export var hide_if_full := true

var ready = false
func _ready():
	self.visible = !hide_if_full
	
	timer.wait_time = 1.0
	timer.autostart = false
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", self, "_on_timeout")
	ready = true

func _on_health_changed(val, max_val):
	if !ready:
		yield(self,"ready")
	var current = val/max_val*100.0
	set("value", current)
	var full = get("value") == 100.0
	if hide_if_full:
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

	
